//
//  PointInformationViewModel.swift
//  Graph
//
//  Created by sarin on 04/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

class PointInformationViewModel: Any {
    let point: Point
    let index: Int
    
    init(point: Point, index: Int) {
        self.point = point
        self.index = index
    }
}
