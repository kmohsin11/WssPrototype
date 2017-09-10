//
//  NameChangeViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 05/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class NameChangeViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var salutationsToLoad : [String] = ["Mr.", "Mrs."]
    
    var typestoLoad : [String] = ["General","OBC","SC"]

    @IBOutlet weak var mrbutton: UIButton!
    
    @IBOutlet weak var name: UITextField!
    
   
    @IBOutlet weak var typebtn: UIButton!
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var kno: UITextField!
    @IBOutlet weak var year: UITextField!
    @IBOutlet weak var month: UITextField!
    @IBAction func mrbuttonpressed(_ sender: Any) {
        
        mrpicker.isHidden = false
        typepicker.isHidden = true
    }
    
    @IBAction func typebtnpressed(_ sender: Any) {
        mrpicker.isHidden = true
        typepicker.isHidden = false
    }
    @IBAction func backBtnPressed(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if(self.name.text != "" && self.date.text != "" && self.month.text != "" && self.year.text != "" && kno.text != ""){
            
            
            let myUrl = URL(string: "http://localhost:8080/project/createrequest.php")
            let request = NSMutableURLRequest(url: myUrl! )
            request.httpMethod = "POST";
            let type : String = "Name Change"
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
    
    
    @IBOutlet weak var mrpicker: UIPickerView!
   
    @IBOutlet weak var typepicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mrpicker.delegate = self
        mrpicker.dataSource = self
        
        typepicker.delegate = self
        typepicker.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == mrpicker){
            return salutationsToLoad.count
        }
        else{
            return typestoLoad.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == mrpicker){
            return salutationsToLoad[row]
        }
        else{
            return typestoLoad[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == mrpicker){
            mrbutton.titleLabel?.text = salutationsToLoad[row]
            mrpicker.isHidden = true
        }
        else{
            typebtn.titleLabel?.text = typestoLoad[row]
            typepicker.isHidden = true
        }
        
    }

}
