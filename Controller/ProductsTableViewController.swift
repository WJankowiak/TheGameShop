//
//  ProductsTableViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 12/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
class ProductsTableViewController: UITableViewController, filterDelegate {
    var accessoryIndex: Int = 0
    func setFilters(contents: [String]) {
        self.filters = contents
        self.refreshControl=nil
    }
    
    var products : [Game] = []
    var filteredProducts : [Game] = []
    var filters : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredProducts = products
        self.tableView.estimatedRowHeight = 110
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
        if let receivedFilters = filters
        {
            print (receivedFilters.count)
            applyFilters(filters: receivedFilters)
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! ProductDetailViewCell
        cell.img.image = UIImage(named: filteredProducts[indexPath.row].imageName)
        cell.name.text = filteredProducts[indexPath.row].name
        cell.price.text = String(format:"%.2f zł",filteredProducts[indexPath.row].price)
        cell.platform.text = filteredProducts[indexPath.row].platform
        if filteredProducts[indexPath.row].isFavourite {
            cell.favourite.image = UIImage(named: "heart2")
        } else {
            cell.favourite.image = UIImage(named: "heart1")
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showProductDetail" {
            if let indexPath = tableView?.indexPathForSelectedRow {
                detailGame = filteredProducts[indexPath.row]
            }
        }
        if segue.identifier == "showProductDetail2" {
                print ("SECOND SEQUE")
                detailGame = filteredProducts[accessoryIndex]
        }
    }
    
    @IBAction func goNext(_ sender: Any) {
        filters = []
        filteredProducts = products
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterController")as! FilterViewController
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func applyFilters(filters: [String]){
        if (filters.count == 0) {
            filteredProducts = products
        } else {
            applyPlatformFilter(filter: filters[0])
            applyPriceFilter(filter: filters[1])
            self.tableView.reloadData()
        }
    }
    func applyPlatformFilter(filter: String){
        if filter != "BRAK" {
            for product in filteredProducts{
                if (filter != product.platform) {
                    let index = filteredProducts.index{$0 === product}
                    filteredProducts.remove(at: index!)
                }
            }
        }
    }
    
    func applyPriceFilter (filter: String){
        let fil = (filter as NSString).floatValue
        for product in filteredProducts{
            if (fil <= product.price) {
                let index = filteredProducts.index{$0 === product}
                filteredProducts.remove(at: index!)
            }
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let configuration = UISwipeActionsConfiguration (actions: [])
        return configuration
    }

    func addToBasket(index: Int) {
        print ("addToBasket has index: ", index)
        DatabaseManager.addToBasket(game: self.filteredProducts[index])
        basketGames.append(self.filteredProducts[index])
    }
    @IBAction func addToFav(_ sender: Any) {
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        if (!filteredProducts[(indexPath!.row)].isFavourite){
            DatabaseManager.addToFav(game: filteredProducts[(indexPath?.row)!])
            filteredProducts[indexPath!.row].isFavourite = true
            self.tableView.reloadData()
        } else {
            DatabaseManager.removeFromFav(game: filteredProducts[indexPath!.row])
            filteredProducts[indexPath!.row].isFavourite = false
            self.tableView.reloadData()
            
        }
    }

}
