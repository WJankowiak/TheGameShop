//
//  ProductDetailViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 16/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet var productView: ProductDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productView.img.image = UIImage (named: detailGame.imageName)
        productView.name.text = detailGame.name
        productView.price.text = String(format:"%.2f zł",detailGame.price)
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
        DatabaseManager.addToBasket(game: detailGame)
        basketGames.append(detailGame)
    }
    @IBAction func addToFav(_ sender: Any) {
        if !detailGame.isFavourite {
            DatabaseManager.addToFav(game: detailGame)
            favouriteGames.append(detailGame)
            detailGame.isFavourite = true
        
        } else {
            DatabaseManager.removeFromFav(game: detailGame)
            let indexToRemove = favouriteGames.index{$0 === detailGame}
            favouriteGames.remove(at: indexToRemove!)
            detailGame.isFavourite = true
        }
    }
    
}
