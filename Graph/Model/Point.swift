//
//  Point.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Point: NSObject {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    
    var cgPoint: CGPoint{
        return CGPoint(x: x, y: y)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(x: CGFloat, y: CGFloat){
        self.init()
        self.x = x
        self.y = y
    }
    
    convenience init(json: JSON) {
        self.init()
        x = CGFloat(json["x"].doubleValue)
        y = CGFloat(json["y"].doubleValue)
    }
    
    static func randomPoint() -> Point{
        return Point(x: CGFloat.random(in: -1000...1000), y: CGFloat.random(in: -1000...1000))
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let point = object as? Point{
            return point.x == x && point.y == y
        }
        return false
    }
    
    
}
