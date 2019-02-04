//
//  FavouritesController.swift
//  TheGameShop
//
//  Created by Wojtek on 12/01/2019.
//  Copyright © 2019 Wojciech Jankowiak. All rights reserved.
//

import UIKit
var favouriteGames :[Game] = DatabaseManager.getFavGames()

class FavouritesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 110
        print(favouriteGames.count)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteGames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! ProductDetailViewCell
        cell.img.image = UIImage(named: favouriteGames[indexPath.row].imageName)
        cell.name.text = favouriteGames[indexPath.row].name
        cell.price.text = String(format:"%.2f zł",favouriteGames[indexPath.row].price)
        cell.platform.text = favouriteGames[indexPath.row].platform
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            print ("Starting to delete")
            DatabaseManager.removeFromFav(game: favouriteGames[indexPath.row])
            favouriteGames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("leadingHasIndex",indexPath.row)
        let insertAction = UIContextualAction(style: .normal, title: "Do Koszyka") {(action, view, handler) in self.addToBasket(index: indexPath.row) }
        insertAction.backgroundColor = UIColor.green
        let configuration = UISwipeActionsConfiguration (actions: [insertAction])
        tableView.reloadData()
        return configuration
    }
    func addToBasket(index: Int) {
        print ("addToBasket has index: ", index)
        DatabaseManager.addToBasket(game: favouriteGames[index])
        basketGames.append(favouriteGames[index])
    }

}
