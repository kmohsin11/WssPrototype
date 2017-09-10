//
//  Complaint.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 10/09/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import Foundation

class Complaint {
    
    var status: String
    var date: String
    var complaintType: String
    var kno: String
    var complaintno: String
    var days: String
    
    init(status: String, date: String, complaintType: String, kno: String, complaintno: String, days: String) {
        self.status = status
        self.date = date
        self.complaintType = complaintType
        self.kno = kno
        self.complaintno = complaintno
        self.days = days
    }
    
    var description: String {
        
        return "\(kno)\n\(complaintType)\n\(date)\n\(days)\n\(status)"
        
    }

    
}
