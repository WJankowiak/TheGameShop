//
//  SuggestedPageViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 11/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class SuggestedPageViewController: UIViewController {
    @IBOutlet var contentImageView :UIImageView!
    
    var index = 0
    var product = Game()
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView.image = UIImage(named : product.imageName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SuggestedDetail" {
            detailGame = product
        }
    }
}
