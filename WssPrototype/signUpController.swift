//
//  signUpController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 30/06/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class signUpController: UIViewController {

    @IBOutlet weak var kno: UITextField!
    @IBOutlet weak var mobileno: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var otpfield: UITextField!
    @IBOutlet weak var generateotpbtn: UIButton!
    
    private var otp = 0
    
    @IBAction func generateotpbtnpressed(_ sender: Any) {
    
        generateotpbtn.isEnabled = false
        otpfield.isEnabled = true
        
       otp = Int(arc4random_uniform(999)) + 9000;
        
        print(otp)
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func signuppressed(_ sender: Any) {
        
        let knotext : String = kno.text!
        print("err")
        let mobilenotext : String = mobileno.text!
        let passwordtext : String = password.text!
        var otptext = 0
        if(otpfield.text != ""){
        otptext = Int(otpfield.text!)!
        }
    

        print(otptext.description)
        if(knotext != "" && mobilenotext != "" && passwordtext != "" && otptext.description != ""  && (otptext == otp)){
            

                    // var responseString = String
                    //print(String(describing: data!))
                    if(self.checkUser(knotext, mobilenotext)){
                        
                        print("userokk")
                        
                        let myUrl = URL(string: "http://localhost:8080/project/signup.php")
                        let request = NSMutableURLRequest(url: myUrl! )
                        request.httpMethod = "POST";
                        //print(mobno)
                        let poststring = "userid=\(mobilenotext)&passw=\(passwordtext)";
                        
                        request.httpBody = poststring.data(using: String.Encoding.utf8);
                        // URLSession.shared.da
                        //  print(request.httpBody ?? "x")
                        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                            
                            if error != nil {
                                print("Failed to download data")
                                
                                let alertController = UIAlertController(title: "ERROR!!", message:
                                    "Wrong Credentials. Please check again.", preferredStyle: UIAlertControllerStyle.alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                                
                                self.present(alertController, animated: true, completion: nil)
                                
                                self.kno.text = ""
                                self.mobileno.text = ""
                                self.password.text = ""
                                self.otpfield.text = ""

                            }
                            else {
                                print("okk");
                                
                                DispatchQueue.main.async {
                                    
                                    let userInfo : NSDictionary = ["kno" : knotext, "mobileno" : mobilenotext]
                                    
                                    self.performSegue(withIdentifier: "loggedIn", sender: userInfo)
                                    
                                    
                                }
                            }
                        
                        }

            task.resume()
        
            }
 
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? LoggedInViewController{
            if let info = sender as? NSDictionary{
            destination.userInfo = info
            }
        }
    }
    
    func checkUser(_ knum : String , _ mobnum : String ) -> Bool {
        print("checkusercalled")
        let myUrl = URL(string: "http://localhost:8080/project/checkuser.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        //print(mobno)
        let poststring = "kno=\(knum)&mobno=\(mobnum)";
        
        request.httpBody = poststring.data(using: String.Encoding.utf8);

        
        var returnValue : Bool = false
        let sem = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
                returnValue = false
                sem.signal()
            }else {
                
                if(self.parseJSON( data! )){
                    print("parsejsoncalled")
                    returnValue = true
                    print(returnValue)
                    sem.signal()
                    
                } else{
                    returnValue = false
                    sem.signal()
                }
            }
            
        }
        task.resume()
  
        sem.wait()
        print(returnValue)
        return returnValue
        
    }
    
    func parseJSON(_ data : Data) -> Bool {
        
        var jsonElement = Bool()
        do{
            jsonElement = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! Bool
            
            if(jsonElement){
                
                return true
            }
            else{
                print("false")
                return false
            }
            
        } catch let error as NSError {
            
            print(error)
            print("sadsa")
            return false
        }
        
    }


}
