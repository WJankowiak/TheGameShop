//
//  ProductDetailViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 16/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    var product:  Game = Game()
    @IBOutlet var productView: ProductDetailView!
    
    @IBOutlet var test: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        productView.img.image = UIImage (named: product.imageName)
        productView.name.text = product.name
        productView.desc.text = product.description
        productView.price.text = String(format:"%.2f zł",product.price)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addToBasket(sender: AnyObject) {
        let alert = UIAlertController (title: "Na pewno?", message: "Jesteś pewien, że chcesz dodać ten produkt do koszyka?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAK", style: .default, handler:{ action in self.confirm()} ))
        alert.addAction(UIAlertAction(title: "NIE", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
    
    func confirm(){
        DatabaseManager.addToBasket(game: product)
        basketGames.append(product)
    }

}
