//
//  BasketViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 17/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
var basketGames :[Game] = []

class BasketViewController: UIViewController {
    var price: Float = 0
    
    @IBOutlet weak var Price: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        for pr in basketGames {
            price += pr.price
        }
        Price.text = String(format:"Suma %.2f zł",price)
        // Do any additional setup after loading the view.
    }
    func changeTotal() {
        var total = Float(0)
        for b  in basketGames {
            total += b.price
        }
        price = total
        Price.text = String(format:"Suma %.2f zł",price)
    }

}
