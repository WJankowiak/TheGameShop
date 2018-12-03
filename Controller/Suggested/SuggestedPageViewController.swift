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
    var imageFile = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        contentImageView.image = UIImage(named : imageFile)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        print ("CLICK")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SuggestedDetail" {
            let destinationController = segue.destination as! ProductDetailViewController
            print (" SEQUE" )
        }
    }
}
