//
//  NetworkService.swift
//  Graph
//
//  Created by sarin on 04/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkService: Any{
    private let baseURL: URL = URL(string: "https://demo.bankplus.ru/mobws/json/")!
    private var sessionManager: Alamofire.SessionManager = {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "demo.bankplus.ru" : .disableEvaluation
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()

    func downloadPoints(count: Int, completion: @escaping (_: [Point]?, _: Error?) -> ()) {
        let url = baseURL.appendingPathComponent("pointsList")
        let parameters = ["version": 1.1,
                          "count": count] as [String : Any]
        sessionManager.request(url,
                               method: .post,
                               parameters: parameters,
                               encoding: Alamofire.JSONEncoding.default,
                               headers: nil)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let data):
                    guard let json = try? JSON(data: data) else {
                        completion(nil, GraphError.jsonEncodingFailed)
                        return
                    }
                    let jsonResponse = json["response"]
                    var points = [Point]()
                    for pointJson in jsonResponse["points"].arrayValue{
                        points.append(Point(json: pointJson))
                    }
                    for _ in 0..<count{
                        points.append(Point.randomPoint())
                    }
                    guard points.count > 0 else{
                        completion(nil, GraphError.invalidServerResponse)
                        return
                    }
                    completion(points, nil)
                case .failure(_):
                    completion(nil, GraphError.responseValidationFailure)
                }
        }
    }
    
}
