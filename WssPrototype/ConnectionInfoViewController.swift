//
//  ConnectionInfoViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 03/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ConnectionInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var ListOfConnections: UITableView!
    
    var _kno : String!
    
    var kno : String {
        get {
            return _kno
        }
        set {
            _kno = newValue
        }
    }
    
    var itemsToLoad : [String] = []
    
    @IBAction func backBtnPresssed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListOfConnections.dataSource = self
        ListOfConnections.delegate = self
        
        ListOfConnections.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        let myUrl = URL(string: "http://localhost:8080/project/getconnectioninfo.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";

        print("knumber is \(self.kno)")
        let poststring = "kno=\(self.kno)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);

        let task1 = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                
                var jsonResult = NSArray()
                
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                                        
                } catch let error as NSError {
                    print(error)
                    
                }
                
                self.crminfo(jsonResult[0] as! NSDictionary)
                self.techinfo(jsonResult[1] as! NSDictionary)
                
                DispatchQueue.main.async {
                    
                    self.ListOfConnections.reloadData()
                    
                }
                
                
            }
            
        }
        task1.resume()
        
        
       


    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToLoad.count
    }
    //tableV
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "orangeCell", for: indexPath) as! CustomTableViewCell
        
        
        cell.label?.text = self.itemsToLoad[indexPath.row]
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func crminfo(_ jsonElement : NSDictionary){
        
        let personal : String = "PERSONAL INFO"
        self.itemsToLoad.append(personal)
        
        let name : String = "Name: \(jsonElement["name"] as! String)"
        self.itemsToLoad.append(name)
        
        let accno : String = "Acc No: \(jsonElement["accno"] as! String)"
        self.itemsToLoad.append(accno)
        
        let address : String = "Address: \(jsonElement["address"] as! String)"
        self.itemsToLoad.append(address)
        
      
        
    }
    func techinfo(_ jsonElement : NSDictionary){
        
        let tech : String = "TECHNICAL INFO"
        self.itemsToLoad.append(tech)
        
        let phase : String = "Phase: \(jsonElement["phase"] as! String)"
        self.itemsToLoad.append(phase)
        
        let sancload : String = "Sanctioned Load: \(jsonElement["sanctionedload"] as! String)"
        self.itemsToLoad.append(sancload)
        
        let connectedload : String = "Connected Load: \(jsonElement["connectedload"] as! String)"
        self.itemsToLoad.append(connectedload)
        
        let tarrif : String = "Tarrif Code: \(jsonElement["tarrifcode"] as! String)"
        self.itemsToLoad.append(tarrif)
        
    }
    

}
