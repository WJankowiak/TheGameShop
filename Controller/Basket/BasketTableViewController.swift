//
//  BasketTableViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 17/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class BasketTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print (basketGames.count)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return basketGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("In celForRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        print ("after deque")

        cell.img.image = UIImage(named: basketGames[indexPath.row].imageName)
        cell.name.text = basketGames[indexPath.row].name
        cell.price.text = String(format:"%.2f zł",basketGames[indexPath.row].price)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print ("Starting to delete")
            DatabaseManager.removeFromBasket(game: basketGames[indexPath.row])
            basketGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    

}
