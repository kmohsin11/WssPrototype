//
//  TransactionViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var itemsToLoad : [NSDictionary] = []
    @IBOutlet weak var transactionstable: UITableView!
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transactionstable.delegate = self
        transactionstable.dataSource = self
        
        transactionstable.register(TransactionCell.self, forCellReuseIdentifier: "Cell")
        
    transactionstable.tableFooterView = UIView()
        
        self.retrieveData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsToLoad.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "transactioncell", for: indexPath) as! TransactionCell
        
        let jsonElement : NSDictionary = itemsToLoad[indexPath.row]
        
        cell.kno.text = "Kno :\(jsonElement["kno"] as! String)"
        
        cell.amount.text = "Amount Rs :\(jsonElement["amount"] as! String)"
        cell.date.text = jsonElement["date"] as? String

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func retrieveData(){

        
        let myUrl = URL(string: "http://localhost:8080/project/gettransactions.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";

        let userid : String = UserDefaults.standard.object(forKey: "userid") as! String
        let poststring = "userid=\(userid)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);

        let task1 = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                
                var jsonResult = NSArray()
                
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                    //print(jsonResult.count)
                    
                } catch let error as NSError {
                    print(error)
                    
                }
             
                
                for i in 0..<jsonResult.count{
                    
                    self.itemsToLoad.append(jsonResult[i] as! NSDictionary)
                    
                }
                
                DispatchQueue.main.async {
                    self.transactionstable.reloadData()
                }
                
            }
            
        }
        task1.resume()
        
        

        
    }


}
