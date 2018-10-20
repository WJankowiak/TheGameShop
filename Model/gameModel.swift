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
    
    init(name_ : String, description_ : String, imageName_ : String, price_ : Float32) {
        name = name_
        description = description_
        imageName = imageName_
        price = price_
    }
    
    convenience init() {
        self.init(name_: "", description_: "", imageName_: "", price_: 0)
    }
}
