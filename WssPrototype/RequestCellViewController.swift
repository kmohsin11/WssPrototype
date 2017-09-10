//
//  RequestCellViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 04/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class RequestCellViewController: UITableViewCell {

    @IBOutlet weak var statusColor: UIImageView!

    @IBOutlet weak var date: UILabel!

    @IBOutlet weak var requestType: UILabel!
    
    @IBOutlet weak var kno: UILabel!

    func configureCell(request: Request) {
        
        self.date.text = request.date
        self.requestType.text = request.requestType
        self.kno.text = request.kno
        
        if request.status == "1" {
            self.statusColor.backgroundColor = UIColor.green
        } else {
            self.statusColor.backgroundColor = UIColor.red
        }
        
    }


}
