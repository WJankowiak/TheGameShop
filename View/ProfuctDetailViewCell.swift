//
//  ProfuctDetailViewCell.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 12/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class ProductDetailViewCell: UITableViewCell {
    @IBOutlet var img : UIImageView!
    @IBOutlet var favourite : UIImageView!

    @IBOutlet var name : UILabel!
    @IBOutlet var price : UILabel!
    @IBOutlet var platform : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
