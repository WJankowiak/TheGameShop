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

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("photo2", product.imageName)
        productView.img.image = UIImage (named: product.imageName)
        productView.name.text = product.name
    }
        // Do any additional setup after loading the view.

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
