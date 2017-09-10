//
//  Request.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 10/09/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import Foundation
import UIKit


class Request {

    
    var status: String
    var date: String
    var requestType: String
    var kno: String
    var requestno: String
    
    init(status: String, date: String, requestType: String, kno: String, requestno: String) {
        self.status = status
        self.date = date
        self.requestType = requestType
        self.kno = kno
        self.requestno = requestno
    }

    var description: String {
        
        return "\(kno)\n\(requestType)\n\(date)\n\(status)"
        
    }

}
