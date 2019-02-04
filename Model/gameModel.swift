//
//  gameModel.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 11/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import Foundation

class Game {
    var name        : String
    var description : String
    var imageName   : String
    var price       : Float32
    var platform    : String
    var type        : String
    var isInBasket  : Bool
    var isFavourite : Bool
    var latitude    : Float32
    var longitude   : Float32
    init(name_ : String, description_ : String, imageName_ : String, price_ : Float32, platform_ : String, type_ : String, isInBasket_: Bool, latitude_: Float32, longitude_: Float32, isFavourite_: Bool) {
        name        = name_
        description = description_
        imageName   = imageName_
        price       = price_
        platform    = platform_
        type        = type_
        isInBasket  = isInBasket_
        isFavourite = isFavourite_
        latitude    = latitude_
        longitude   = longitude_
    }
    
    convenience init() {
        self.init(name_: "", description_: "", imageName_: "", price_: 0, platform_: "", type_: "", isInBasket_: false, latitude_: 0, longitude_: 0, isFavourite_: false)
    }
}
