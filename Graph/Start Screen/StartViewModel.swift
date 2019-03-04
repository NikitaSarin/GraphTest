//
//  StartViewModel.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

class StartViewModel {
    private let networkService = NetworkService()
    private var points: [Point]?
    func validate(_ string: String) ->  (success: Bool, value: Int){
        let value = Int(string) ?? 0
        return  (value > 0, value)
    }
    
    func downloadPoints(count: Int, completion: @escaping (_: Error?) -> ()) {
        networkService.downloadPoints(count: count) { (points, error) in
            guard error == nil,
                let points = points else{
                    completion(error)
                    return
            }
            self.points = points
            completion(nil)
        }
    }
    
    func viewmodelForTableViewController() -> PointsTableViewModel?{
        guard let points = points else{
            return nil
        }
        return PointsTableViewModel(points: points)
    }
    
}
