//
//  GraphView.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

enum LineType{
    case straight
    case smooth
    
    var name: String {
        switch self {
        case .straight:
            return NSLocalizedString("Прямая", comment: "")
        case .smooth:
            return NSLocalizedString("Гладкая", comment: "")
        }
    }
}

class GraphView: UIView {
    
    private var lineLayer: CAShapeLayer?
    private var pointLayers = [CALayer]()
    private let contentArea = CGRect(x: 0.1, y: 0.1, width: 0.8, height: 0.8)
    private var actualSize = CGSize.zero
    var points: [Point]?{
        didSet{
            createNewGraph()
        }
    }
    
    var lineType: LineType = .straight{
        didSet{
            guard let points = points, points.count > 0 else {
                return
            }
            createGraphLine(for: points, type: lineType)
        }
    }
    
    @IBInspectable public var lineColor: UIColor?
    @IBInspectable public var pointColor: UIColor?
    private let pointSize: CGFloat = 10
    private let lineWidth: CGFloat = 3
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if actualSize != bounds.size{
            actualSize = bounds.size
            createNewGraph()
        }
    }
    
    private func createNewGraph(){
        guard
            let points = points else {
                return
        }
        createGraphLine(for: points, type: lineType)
        createGraphPoints(for: points)
    }
    
    private func createGraphPoints(for points: [Point]){
        for layer in pointLayers {
            layer.removeFromSuperlayer()
        }
        pointLayers.removeAll()
        for point in points {
            let pointLayer = CALayer()
            pointLayer.backgroundColor = pointColor!.cgColor
            let absolute = absolutePoint(from: point)
            pointLayer.frame = CGRect(x: 0, y: 0, width: pointSize, height: pointSize)
            pointLayer.position = absolute.cgPoint
            pointLayer.cornerRadius = pointSize * 0.5
            layer.addSublayer(pointLayer)
            pointLayers.append(pointLayer)
        }
    }
    
    private func createGraphLine(for points: [Point], type: LineType){
        guard points.count > 1 else {
            return
        }
        var type = lineType
        if points.count < 3{
            type = .straight
        }
        self.lineLayer?.removeFromSuperlayer()
        let path = UIBezierPath()
        path.move(to: absolutePoint(from: points.first!).cgPoint)
        switch type{
        case .straight:
            for i in 1..<points.count {
                let absolute = absolutePoint(from: points[i])
                path.addLine(to: absolute.cgPoint)
            }
        case .smooth:
            var absolutePonts  = [CGPoint]()
            for point in points{
                absolutePonts.append(absolutePoint(from: point).cgPoint)
            }
            path.interpolatePointsWithHermite(points: absolutePonts)
            break
        }
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.lineWidth = lineWidth
        lineLayer.strokeColor = lineColor!.cgColor
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.lineCap = .round
        if lineType == .smooth{
            lineLayer.lineJoin = .round
        }
        layer.insertSublayer(lineLayer, at: 0)
        self.lineLayer = lineLayer
    }
    
    private func absolutePoint(from normalized: Point) -> Point{
        let absolute = Point()
        let width = bounds.width * contentArea.width * 0.5
        let height = bounds.height * contentArea.height * 0.5
        absolute.x = contentArea.minX * bounds.width + width + width * normalized.x
        absolute.y = contentArea.minY * bounds.height + height - height * normalized.y
        return absolute
    }
    
    func zoom(to scale: CGFloat){
        lineLayer?.lineWidth = lineWidth / scale
        for layer in pointLayers {
            layer.transform = CATransform3DMakeScale(1 / scale, 1 / scale, 1.0)
        }
    }
}
