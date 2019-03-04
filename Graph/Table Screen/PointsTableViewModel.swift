//
//  TableViewModel.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

enum SectionType {
    case pointsInformation
    case graph
    
    func identifier() -> String {
        switch self {
        case .pointsInformation:
            return "PointInformationTableViewCell"
        case .graph:
            return "GraphTableViewCell"
        }
    }
}

class PointsTableViewModel {
    let content: [SectionType] = [.pointsInformation, .graph]
    let lineTypes: [LineType] = [.straight, .smooth]
    let defultLineType: LineType = .straight
    let points: [Point]
    private(set) var normalizedPoints: [Point]?
    
    init(points: [Point]) {
        self.points = points
        self.normalizedPoints = normalize(points)
    }
    
    private func normalize(_ points: [Point]) -> [Point]{
        var normalized = [Point]()
        var minX = CGFloat.greatestFiniteMagnitude
        var minY = CGFloat.greatestFiniteMagnitude
        var maxX = CGFloat.leastNormalMagnitude
        var maxY = CGFloat.leastNormalMagnitude
        for point in points {
            if point.x < minX{
                minX = point.x
            }
            if point.y < minY{
                minY = point.y
            }
            if point.x > maxX{
                maxX = point.x
            }
            if point.y > maxY{
                maxY = point.y
            }
        }
        for point in points {
            normalized.append(Point(x: (point.x - minX) / (maxX - minX) * 2 - 1,
                                    y: (point.y - minY) / (maxY - minY) * 2 - 1))
        }
        return normalized.sorted(by: {$0.x < $1.x})
    }
    
    func countOfRows(in section: Int) -> Int{
        guard section >= 0 && section < content.count else{
            return 0
        }
        switch content[section] {
        case .pointsInformation:
            return points.count
        default:
            return 1
        }
    }
    
    func viewmodel(for indexPath: IndexPath) -> Any?{
        switch content[indexPath.section] {
        case .pointsInformation:
            let index = indexPath.row
            return PointInformationViewModel(point: points[index], index: index)
        case .graph:
            return GraphCellViewModel(points: self.normalizedPoints)
        }
    }
}
