//
//  ViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 28/06/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uniname: UITextField!
    
    @IBOutlet weak var unino: UITextField!
    
    @IBOutlet weak var pass1: UITextField!
    
    @IBOutlet weak var signinbtn: UIButton!
    
    @IBOutlet weak var signupbtn: UIButton!
    var login_session:String = ""
    
    @IBAction func checkSignIn(_ sender: Any) {
        
        let mobno : String = unino.text!
        let pass2 :  String = pass1.text!
        
        if (mobno != "" && pass2 != "" ){
        let myUrl = URL(string: "http://localhost:8080/project/signup_php.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        let poststring = "userid=\(mobno)&passw=\(pass2)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);

        let task1 = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {

                if(self.parseJSON(data!)){
                    DispatchQueue.main.async(execute: self.createSession)
         
                }else{
                    self.unino.text = ""
                    self.pass1.text = ""
                }
            }
            
        }
        task1.resume()
        }
        
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //self.unino.text = ""
        
        
      
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil
        {
            login_session = preferences.object(forKey: "session") as! String
            print(login_session)
            check_session()
            
            // DispatchQueue.main.async(execute : self.LoginDone)
        }
    }
    
    func createSession(){
        
        let myUrl = URL(string: "http://localhost:8080/project/createsession.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        //print(mobno)
        let mobno : String = unino.text!
     //   let x : String = "2"
        let poststring = "userid=\(mobno)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData;
        // URLSession.shared.da
        //  print(request.httpBody ?? "x")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                
                do{
                    let jsonElement = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! String
                    
                    
                    self.login_session = jsonElement
                    
                    let preferences = UserDefaults.standard
                    preferences.set(jsonElement, forKey: "session")
                
                    preferences.set(mobno, forKey: "userid")

                    
                    DispatchQueue.main.async(execute: self.LoginDone)
                    
                } catch let error as NSError {
                    //return false
                    print(error)
                    print("sadsa")
                }
                
               
            }
            
        }
        task.resume()

        
    }
    
    func LoginDone() {
       // let mobilenotext = unino.text
       
        print("logindone")
        let userInfo : NSDictionary = ["mobileno" : "nothing"]

performSegue(withIdentifier: "signedIn", sender: userInfo)
        
        print("segueperformed")
        
    }
    
    func check_session(){
        
        var userElement = NSDictionary()
        var userId = String()
        
        let myUrl = URL(string: "http://localhost:8080/project/checksession.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        //print(mobno)
        let poststring = "sessionid=\(self.login_session)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);
       request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData;

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                
                var jsonResult = NSArray()
                
                do{
                    jsonResult = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
                    
                    print(jsonResult[0],jsonResult[1])
                    
                } catch let error as NSError {
                    print(error)
                    
                }
                
                let statusElement : NSDictionary = jsonResult[0] as! NSDictionary
                
                let status : Bool = statusElement["status"] as! Bool
                
                if(status){
                    
                    userElement = jsonResult[1] as! NSDictionary
                    
                    userId = userElement["userid"] as! String

                    DispatchQueue.main.async {
                        let preferences = UserDefaults.standard
                        preferences.set(userId, forKey: "userid")
                        self.LoginDone()
                    }
                    
                
            }
            
        }
        }
        task.resume()
        

        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func LoginToDo(){
        unino.isEnabled = true
        pass1.isEnabled = true
        signinbtn.isEnabled = true
        signupbtn.isEnabled = true
        
    }
    
    func parseJSON(_ data:Data) -> Bool {
        

        var jsonElement = NSDictionary()
        do{
            jsonElement = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            let status:Int = jsonElement["status"] as! Int
            if(status==1){
            return true
            }else{
                return false
            }
            //print(jsonElement)
            
        } catch let error as NSError {
            
            print(error)
            
            return false

        }

}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let destination = segue.destination as? LoggedInViewController{
            if let info = sender as? NSDictionary{
            destination.userInfo = info
            }
        }
    }
}
