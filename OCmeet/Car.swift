//
//  Car.swift
//  OCmeet
//
//  Created by Jirka Ketner on 03/05/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import Foundation

class Car {
    var id: Int?
    var number: Int
    var category: String
    var description: String?
    var imageURL: String
    var thumbnailURL: String
    var owner: String?
    
    //required override init(){
    //}
    
    required init?(id: Int?, number: Int, category: String, description: String?,
                   imageURL: String, thumbnailURL: String, owner: String?) {
        self.id = id
        self.number = number
        self.category = category
        self.description = description
        self.imageURL = imageURL
        self.thumbnailURL = thumbnailURL
        self.owner = owner
    }
    
    /*
    
    func toString() -> String {
        return "ID: \(self.id), " +
            "Number: \(self.number), " +
            "Category: \(self.category), " +
            "Owner: \(self.owner)\n" +
            "Description: \(self.description)\n" +
            "ImageURL: \(self.imageURL)\n" +
            "ThumbnailURL: \(self.thumbnailURL)\n"
    }
     */
}
