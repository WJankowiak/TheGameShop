//
//  BasketCell.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 17/11/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit

class BasketCell: UITableViewCell {

    @IBOutlet var img : UIImageView!
    @IBOutlet var name : UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
