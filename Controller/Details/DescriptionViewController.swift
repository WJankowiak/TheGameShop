//
//  DescriptionViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 08/12/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var Description: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Description.isEditable = false
        Description.isUserInteractionEnabled = true
        Description.isScrollEnabled = true
        Description.text = detailGame.description
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
