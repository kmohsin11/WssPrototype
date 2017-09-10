//
//  NewComplaintViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class NewComplaintViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var itemstoLoad : [String] = ["complaint 1", "complaint 2", "complaint 3"]
    
    @IBOutlet weak var complainttypebtn: UIButton!
    @IBOutlet weak var complainttypepicker: UIPickerView!
   
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var kno: UITextField!
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        
        if(self.kno.text != "" && complainttypebtn.titleLabel?.text != "Select Complaint Type"){
            
            
            let myUrl = URL(string: "http://localhost:8080/project/createcomplaint.php")
            let request = NSMutableURLRequest(url: myUrl! )
            request.httpMethod = "POST";
            //print(mobno)
            let type : String = (complainttypebtn.titleLabel?.text)!
            let userid : String = UserDefaults.standard.object(forKey: "userid") as! String
            let knostring : String = self.kno.text!
            let poststring = "kno=\(knostring)&userid=\(userid)&type=\(type)";
            
            request.httpBody = poststring.data(using: String.Encoding.utf8);

            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                
                if error != nil {
                    print("Failed to download data")
                                    }
                else {
                    print("okk");
                    
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
            

        
    }
    
    @IBAction func complainttypeBtnPressed(_ sender: Any) {
        
        complainttypepicker.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        complainttypepicker.delegate = self
        complainttypepicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemstoLoad.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return itemstoLoad[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        complainttypebtn.titleLabel?.text = itemstoLoad[row]
        complainttypepicker.isHidden = true
    }

   

}
