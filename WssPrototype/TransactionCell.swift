//
//  TransactionCell.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    

    @IBOutlet weak var kno: UILabel!
    
    @IBOutlet weak var amount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
