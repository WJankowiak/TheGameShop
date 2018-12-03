//
//  gameModelData.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 11/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import Foundation

class gameModelData {
    var  gamesData : [Game ] =
        [Game (name_: "Diablo III", description_: "This is a very cool game, that is loved by many a people", imageName_: "Diablo_III", price_: 122.5, platform_ : "PC", type_ : "Strategy", isInBasket_: true),
         Game (name_: "Grand Theft Auto 5", description_: "This is a very cool game, that is loved by many a people", imageName_: "GTA_V", price_: 99.99, platform_: "PC", type_ : "Racing", isInBasket_: false),
         Game (name_: "Witcher 3", description_: "This is a very cool game, that is loved by many a people", imageName_: "Witcher_3", price_: 220.00, platform_ : "PS4", type_ : "Action", isInBasket_: true),
    ]
}
