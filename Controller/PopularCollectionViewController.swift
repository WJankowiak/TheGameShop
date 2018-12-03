//
//  PopularCollectionCollectionViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 12/10/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PopularCollectionCell"

class PopularCollectionViewController: UICollectionViewController {
    var data = DatabaseManager.getAllGames()
    var best = DatabaseManager.getAllGames()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellIdentifier = "PopularCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PopularCollectionCell
        cell.cover?.image = UIImage (named: data[indexPath.row].imageName)
        cell.price.text = data[indexPath.row].name
    
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showProductDetail" {
            if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                let destinationController = segue.destination as! ProductDetailViewController
                destinationController.product = best[indexPath.row]
            }
        }
    }
}
