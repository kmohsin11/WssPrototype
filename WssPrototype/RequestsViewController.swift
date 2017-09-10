//
//  RequestsViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 04/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var newrequestflag : Bool = true
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    var itemsToLoad : [Request] = []
    
    @IBOutlet weak var requests: UITableView!
    
    var userid : String = UserDefaults.standard.object(forKey: "userid") as! String
    
    @IBAction func newrequestBtnPressed(_ sender: Any) {
        
        for i in 0..<itemsToLoad.count{
            let element : Request = itemsToLoad[i]
            let status : String = element.status
            if(status == "0"){
                self.newrequestflag = false
                break
            }
            
        }
        
        performSegue(withIdentifier: "newrequest", sender: self.newrequestflag)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        requests.dataSource = self
        requests.delegate = self
        
        //  requests.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        requests.register(RequestCellViewController.self, forCellReuseIdentifier: "Cell")
        requests.tableFooterView = UIView()
        
        if(!itemsToLoad.isEmpty){
            itemsToLoad.removeAll()
        }
        
        self.retrieveData()
        
        requests.reloadData()
        
    }
    
    func retrieveData(){
        
        
        let myUrl = URL(string: "http://localhost:8080/project/getrequests.php")
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
                    
                    //print(jsonResult.count)
                    
                } catch let error as NSError {
                    print(error)
                    
                }

                for i in 0..<jsonResult.count{
                     let jsonElement : NSDictionary = jsonResult[i] as! NSDictionary
                    
                    let kno : String = "Kno : \(jsonElement["kno"] as! String)"
                    
                    let req : String = "Request : \(jsonElement["requesttype"] as! String)"
                    let reqdate : String = "\(jsonElement["date"] as! String)"
                    let status : String = "\(jsonElement["status"] as! String)"
                    let requestno : String = "Request Id: \(jsonElement["requestno"] as! String)"
                    
                    let request = Request(status: status, date: reqdate, requestType: req, kno: kno, requestno: requestno)
                    
                    self.itemsToLoad.append(request)
                    
                    }
                
                DispatchQueue.main.async {
                    self.requests.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "requestCell", for: indexPath) as! RequestCellViewController
        let request : Request = itemsToLoad[indexPath.row]
        
        cell.configureCell(request: request)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let jsonElement : Request = itemsToLoad[indexPath.row]

        let requestid : String = jsonElement.requestno
        
        let message1 : String = jsonElement.description
        
        let alertController = UIAlertController(title: "\(requestid)", message: message1, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
      //  alertController.
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deselectrow(_ indexPath : IndexPath, action : UIAlertAction) ->(){
        
        requests.deselectRow(at: indexPath, animated: true)
        
        //self.requests.reloadData()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RequestTypesViewController{
            if let flag = sender as? Bool{
                destination.newrequestflag = flag
            }
        }
    }


}
