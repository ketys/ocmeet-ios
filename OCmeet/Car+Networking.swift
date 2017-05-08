//
//  Car+Networking.swift
//  OCmeet
//
//  Created by Jirka Ketner on 04/05/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import Foundation
import Alamofire

extension Car {
    
    convenience init?(json: [String: Any]) {
        guard let number = json["number"] as? Int,
            let category = json["category"] as? String,
            let imageJSON = json["image"] as? [String: String],
            let thumb = imageJSON["thumb"],
            let large = imageJSON["large"]
        else {
            return nil
        }
        
        let id = json["id"] as? Int
        let description = json["description"] as? String
        let owner = json["owner"] as? String
        
        self.init(id: id, number: number, category: category, description: description, imageURL: large,
                  thumbnailURL: thumb, owner: owner)
    }
    
    /*
    class func getById(id: Int, completitionHandler: @escaping (Result<Car>) -> Void) {
        Alamofire.request(OCmeetRouter.getCar(id))
            .responseJSON { response in
                let result = Car.carFromResponse(response: response)
                completitionHandler(result)
            }
    }
    */
    
    public class func carFromResponse(response: DataResponse<Any>) -> Result<Car> {
        guard response.result.error == nil else {
            print("error calling GET on /api/cars/{id}")
            print(response.result.error!)
            return .failure(OCmeetAPIManagerError.network(error: response.result.error!))
        }
        
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get car object as JSON from api")
            return .failure(OCmeetAPIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        guard let car = Car(json: json["data"] as! [String: Any]) else {
            return .failure(OCmeetAPIManagerError.objectSerialization(reason:
                "Could not create Car object from JSON"))
        }
        
        return .success(car)
    }
    
    public class func carArrayFromResponse(response: DataResponse<Any>) -> Result<[Car]> {
        guard response.result.error == nil else {
            print("error calling GET on /api/cars")
            print(response.result.error!)
            return .failure(OCmeetAPIManagerError.network(error: response.result.error!))
        }
        
        guard let json = response.result.value as? [String: Any] else {
            print("didn't get data as JSON from api")
            return .failure(OCmeetAPIManagerError.objectSerialization(reason:
                "Did not get JSON dictionary in response"))
        }
        
        guard let carsArray = json["data"] as? [[String: Any]] else {
            print("didn't get cars as JSON from api")
            return .failure(OCmeetAPIManagerError.objectSerialization(reason:
                "Did not get array of JSON dictionaries in response"))
        }
        let cars = carsArray.flatMap{ Car(json: $0) }
        
        /*
        var cars = [Car]()
        for item in json["data"] as! [[String: Any]] {
            if let car = Car(json: item) {
                cars.append(car)
            }
        }
        */
        
        return .success(cars)
    }

}
