//
//  ComplaintsViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ComplaintsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var complaints: UITableView!
    var itemsToLoad : [Complaint] = []
    var userid : String = UserDefaults.standard.object(forKey: "userid") as! String


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        complaints.dataSource = self
        complaints.delegate = self
        
        //  complaints.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        complaints.register(ComplaintCell.self, forCellReuseIdentifier: "Cell")
        complaints.tableFooterView = UIView()
        
        if(!itemsToLoad.isEmpty){
            itemsToLoad.removeAll()
        }
        
        self.retrieveData()
        
        complaints.reloadData()
        
    }
    
    
    func retrieveData(){

        let myUrl = URL(string: "http://localhost:8080/project/getcomplaints.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";

        let poststring = "userid=\(self.userid)";
        
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
                
                
                print(jsonResult.count)
                
                
                for i in 0..<jsonResult.count{
                    
                    let jsonElement = jsonResult[i] as! NSDictionary
                    
                    let kno : String = "Kno : \(jsonElement["kno"] as! String)"
                    
                    let complainttype : String = "Complaint : \(jsonElement["complainttype"] as! String)"
                    let compdate : String = "\(jsonElement["date"] as! String)"
                    let status : String = "\(jsonElement["status"] as! String)"
                    let complaintid : String = "Request Id: \(jsonElement["complaintno"] as! String)"
                    let days : String = "Days left: \(jsonElement["days"] as! String)"
  
                    let complaint = Complaint(status: status, date: compdate, complaintType: complainttype, kno: kno, complaintno: complaintid, days: days)
                    
                    self.itemsToLoad.append(complaint)
                    
                }
                
                DispatchQueue.main.async {
                    self.complaints.reloadData()
                }

            }
            
        }
        task1.resume()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("no of rows\(itemsToLoad.count)")
        return itemsToLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "complaintcell", for: indexPath) as! ComplaintCell
        let jsonElement : Complaint = itemsToLoad[indexPath.row]
        
        cell.configureCell(complaint: jsonElement)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let complaint : Complaint = itemsToLoad[indexPath.row]

        let message1 : String = complaint.description
        
        let alertController = UIAlertController(title: "\(complaint.complaintno)", message: message1, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
