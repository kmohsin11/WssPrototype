//
//  ComplaintCell.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ComplaintCell: UITableViewCell {

   
    @IBOutlet weak var complainttype: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var kno: UILabel!

    @IBOutlet weak var statusColor: UIImageView!
    
    
    func configureCell(complaint: Complaint) {
        
        self.date.text = complaint.date
        self.complainttype.text = complaint.complaintType
        self.kno.text = complaint.kno
        
        if complaint.status == "1" {
            self.statusColor.backgroundColor = UIColor.green
        } else {
            self.statusColor.backgroundColor = UIColor.red
        }
        
    }

    
}
