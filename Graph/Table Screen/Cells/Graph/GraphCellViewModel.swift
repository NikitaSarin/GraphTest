//
//  GraphViewModel.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

class GraphCellViewModel: Any{
    let lineTypes: [LineType] = [.straight, .smooth]
    let defultLineType: LineType = .straight
    let normalizedPoints: [Point]?
    
    init(points: [Point]?) {
        self.normalizedPoints = points
    }
}
