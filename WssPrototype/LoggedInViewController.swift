//
//  LoggedInViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 01/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class LoggedInViewController: UITabBarController {
    
    private var _userInfo : NSDictionary!
    
    var userInfo: NSDictionary {
        get {
            return _userInfo
        }
        set {
            _userInfo = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(_userInfo!)
        let preferences = UserDefaults.standard
        let userid = preferences.object(forKey: "userid") as! String
        print(userid)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
