//
//  ProductsTableViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 12/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
class SearchTableViewController: UITableViewController, filterDelegate {
    
    func setFilters(contents: [String]) {
        self.filters = contents
    }
    
    var products : [Game] = DatabaseManager.getAllGames()
    var filters : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! ProductDetailViewCell
        cell.img.image = UIImage(named: products[indexPath.row].imageName)
        cell.name.text = products[indexPath.row].name
        cell.price.text = String(format:"%.2f zł",products[indexPath.row].price)
        cell.platform.text = products[indexPath.row].platform
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showProductDetail" {
            if let indexPath = tableView?.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductDetailViewController
                destinationController.product = products[indexPath.row]
            }
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let insertAction = UIContextualAction(style: .normal, title: "Do Koszyka") {(action, view, handler) in self.addToBasket(index: indexPath.row) }
        insertAction.backgroundColor = UIColor.green
        let configuration = UISwipeActionsConfiguration (actions: [insertAction])
        tableView.reloadData()
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration (actions: [])
        return configuration
    }
    
    func addToBasket(index: Int) {
        basketGames.append(self.products[index])
        DatabaseManager.addToBasket(game: self.products[index])
    }
}
