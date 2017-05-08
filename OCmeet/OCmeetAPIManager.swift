//
//  OCmeetAPIManager.swift
//  OCmeet
//
//  Created by Jirka Ketner on 07/05/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import Foundation
import Alamofire

enum OCmeetAPIManagerError: Error {
    case network(error: Error)
    case apiProviderError(reason: String)
    //case authCouldNot(reason: String)
    //case authLost(reason: String)
    case objectSerialization(reason: String)
}

class OCmeetAPIManager {
    static let sharedInstance = OCmeetAPIManager()
    
    func fetchCars(completitionHandler: @escaping (Result<[Car]>) -> Void) {
        let _ = Alamofire.request(OCmeetRouter.getCars()).responseJSON { response in
            let result = Car.carArrayFromResponse(response: response)
            completitionHandler(result)
        }
    }
    
    func imageFrom(urlString: String, completitionHandler: @escaping (UIImage?, Error?) -> Void) {
        let _ = Alamofire.request(urlString).response { dataResponse in
            guard let data = dataResponse.data else {
                completitionHandler(nil, dataResponse.error)
                return
            }
            
            let image = UIImage(data: data)
            completitionHandler(image, nil)
        }
    }
}
