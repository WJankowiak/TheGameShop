//
//  BasketViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 17/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
var basketGames :[Game] = DatabaseManager.getBasketGames()

class BasketViewController: UIViewController {
    var price: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for pr in basketGames {
            price += pr.price
        }
    }
    func changeTotal() {
        var total = Float(0)
        for b  in basketGames {
            total += b.price
        }
        price = total
    }

}
