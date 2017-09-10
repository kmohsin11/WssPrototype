//
//  ProfileViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 03/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        let myUrl = URL(string: "http://localhost:8080/project/deletesession.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        //print(mobno)
        let preferences = UserDefaults.standard
        let mobno : String = preferences.object(forKey: "userid") as! String
        let poststring = "userid=\(mobno)";
        print("logout" + mobno)
        request.httpBody = poststring.data(using: String.Encoding.utf8);
        // URLSession.shared.da
        //  print(request.httpBody ?? "x")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                
                    DispatchQueue.main.async(execute: self.logOut)
                
            }
            
        }
        task.resume()
    

        
      
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIdLabel.text = UserDefaults.standard.object(forKey: "userid") as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func logOut(){
        UserDefaults.standard.removeObject(forKey: "session")
        UserDefaults.standard.removeObject(forKey: "userid")
        performSegue(withIdentifier: "logout", sender: nil)
        
    }

}
