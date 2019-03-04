//
//  UIBezierPath+Interpolation.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import Foundation
import UIKit

extension UIBezierPath
{
    func interpolatePointsWithHermite(points : [CGPoint], alphaX : CGFloat = 0.2, alphaY : CGFloat = 0.2)
    {
        guard !points.isEmpty else { return }
        self.move(to: points[0])
        for index in 0..<points.count - 1
        {
            var currentPoint = points[index]
            var nextIndex = (index + 1) % points.count
            var prevIndex = index == 0 ? points.count - 1 : index - 1
            var previousPoint = points[prevIndex]
            var nextPoint = points[nextIndex]
            let endPoint = nextPoint
            var mx : CGFloat
            var my : CGFloat
            
            if index > 0{
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }else {
                mx = (nextPoint.x - currentPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            
            let controlPoint1 = CGPoint(x: currentPoint.x + mx * alphaX, y: currentPoint.y + my * alphaY)
            currentPoint = points[nextIndex]
            nextIndex = (nextIndex + 1) % points.count
            prevIndex = index
            previousPoint = points[prevIndex]
            nextPoint = points[nextIndex]
            
            if index < points.count - 2{
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }else {
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alphaX, y: currentPoint.y - my * alphaY)
            
            self.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        }
    }
}
