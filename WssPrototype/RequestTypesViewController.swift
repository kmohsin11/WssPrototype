//
//  RequestTypesViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 04/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class RequestTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var _newrequestflag : Bool!
    
    var newrequestflag: Bool {
        get {
            return _newrequestflag
        }
        set {
            _newrequestflag = newValue
        }
    }
    
    var itemsToLoad : [String] = ["Load Change", "Name Change"]
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var pendingrequests: UILabel!
    @IBOutlet weak var requests: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if(self.newrequestflag){
          
        requests.isHidden = false
        requests.dataSource = self
        requests.delegate = self
        
        requests.register(RequestCellViewController.self, forCellReuseIdentifier: "Cell")
        requests.tableFooterView = UIView()
        }
        else{
            pendingrequests.isHidden = false
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "requesttype", for: indexPath) as! RequestTypeCell
        
        cell.type.text = itemsToLoad[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(itemsToLoad[indexPath.section] == "Load Change"){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "loadchangerequest", sender: nil)
            }
        }else{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "namechange", sender: nil)
            }
            
        }
    }
    
    

}
