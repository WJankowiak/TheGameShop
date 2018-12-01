//
//  ProductsTableViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 12/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
class ProductsTableViewController: UITableViewController, filterDelegate {
   
    func setFilters(contents: [String]) {
        self.filters = contents
    }
    
    var products : [Game] = []
    var filteredProducts : [Game] = []
    var filters : [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredProducts = products
        tableView.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showProductDetail" {
            if let indexPath = tableView?.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductDetailViewController
                destinationController.product = filteredProducts[indexPath.row]
            }
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
        for product in filteredProducts{
            if (filter != product.platform) {
                let index = filteredProducts.index{$0 === product}
                filteredProducts.remove(at: index!)
            }
        }
        print ("applied platform filter. Number of filtered: ", filteredProducts.count)
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
        let insertAction = UIContextualAction(style: .normal, title: "Do Koszyka") {(action, view, handler) in basketGames.append(self.filteredProducts[indexPath.row]) }
        insertAction.backgroundColor = UIColor.green
        let configuration = UISwipeActionsConfiguration (actions: [insertAction])
        return configuration
    }
}




