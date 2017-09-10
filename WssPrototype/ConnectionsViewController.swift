//
//  ConnectionsViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 03/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ConnectionsViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var ListOfConnections: UITableView!
     var itemsToLoad: [String] = []
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ListOfConnections.dataSource = self
        ListOfConnections.delegate = self
        
        ListOfConnections.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        ListOfConnections.tableFooterView = UIView()
        
        let myUrl = URL(string: "http://localhost:8080/project/getconnections.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        let userid : String = UserDefaults.standard.object(forKey: "userid") as! String
        print(userid)
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

                var jsonElement = NSDictionary()
                
                for i in 0 ..< jsonResult.count
                {
                    
                    jsonElement = jsonResult[i] as! NSDictionary
                    self.itemsToLoad.append((jsonElement["kno"] as? String)!)
                    print("jsonelement\(jsonElement)")
                    
                }
                
                DispatchQueue.main.async {
                    self.ListOfConnections.reloadData()
                }
            }
            
        }
        task1.resume()
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        ListOfConnections.dataSource = self
        ListOfConnections.delegate = self
        
        ListOfConnections.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print( "itemload\(self.itemsToLoad.count)" )
        return itemsToLoad.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = self.itemsToLoad[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("xxxxx")
        let kno : String = itemsToLoad[indexPath.row]
        
        
        print("User selected table row \(indexPath) and item \(itemsToLoad[indexPath.row])")
       
        DispatchQueue.main.async {
            
        
        self.performSegue(withIdentifier: "connectionInfo", sender: kno)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ConnectionInfoViewController{
            
            if let val = sender as? String{
                destination.kno = val
            }
            
        }
    }

}
