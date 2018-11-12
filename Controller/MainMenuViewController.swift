//
//  MainMenuViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 11/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    @IBOutlet weak var MenuView: UIView!
    @IBOutlet weak var MenuConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuView.layer.shadowOpacity=1
        MenuView.layer.shadowRadius = 6
        MenuConstraint.constant = -326
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func toggleMenu(_ sender: Any) {
        if(MenuConstraint.constant == -326 ) {
            MenuConstraint.constant = 0
            print (MenuConstraint.constant)
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        else {
            MenuConstraint.constant = -326
            print (MenuConstraint.constant)
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var filtered :[Game] = []
        if segue.identifier == "ActionSeque" {
            let destinationController = segue.destination as! ProductsTableViewController
            filtered = filterGames(type : "Action")
            destinationController.products = filtered
        } else if segue.identifier == "RPGSegue" {
            let destinationController = segue.destination as! ProductsTableViewController
            filtered = filterGames(type : "RPG")
            destinationController.products = filtered
            
        } else if segue.identifier == "StratSegue" {
            let destinationController = segue.destination as! ProductsTableViewController
            filtered = filterGames(type : "Strategy")
            destinationController.products = filtered
        }
        
    }
    
    func filterGames(type: String)->[Game] {
        var filtered :[Game] = []
        let gamesList = gameModelData()
        for i in 0 ... gamesList.gamesData.count-1 {
            if gamesList.gamesData[i].type == type {
                filtered.append(gamesList.gamesData[i])
            }
        }
        return filtered
    }
}