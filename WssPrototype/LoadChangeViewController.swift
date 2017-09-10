//
//  LoadChangeViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 04/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit

class LoadChangeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var unitsToLoad : [String] = ["HP","KWH"]
    
    var purposesToLoad : [String] = ["Purpose 1", "Purpose 2"]
    
    var charactersToLoad : [String] = ["HT","LT"]
    
    @IBOutlet weak var unitBtn: UIButton!
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func unitBtnPressed(_ sender: Any) {
        
        unitpicker.isHidden = false
        purposepicker.isHidden = true
        characterpicker.isHidden = true


        
    }
    @IBAction func selectpurposebtnpressed(_ sender: Any) {
        
        purposepicker.isHidden = false
        characterpicker.isHidden = true
        unitpicker.isHidden = true


        
    }
    @IBAction func characterbtnpressed(_ sender: Any) {
        
        characterpicker.isHidden = false
        purposepicker.isHidden = true
        unitpicker.isHidden = true


        
    }
    @IBOutlet weak var selectcharacterbtn: UIButton!
    @IBOutlet weak var selectpurposebtn: UIButton!
    @IBOutlet weak var loadtype: UISegmentedControl!
    
    @IBOutlet weak var unitpicker: UIPickerView!
    
    @IBOutlet weak var purposepicker: UIPickerView!
    
    @IBOutlet weak var characterpicker: UIPickerView!
    
    
    @IBOutlet weak var supplyvoltage: UITextField!
    
    @IBOutlet weak var loadChange: UITextField!
    
    
    @IBOutlet weak var kno: UITextField!
    @IBAction func loadtypeselected(_ sender: Any) {
        
        print(loadtype.titleForSegment(at: loadtype.selectedSegmentIndex)!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        unitpicker.delegate = self
        unitpicker.dataSource = self
        
        purposepicker.delegate = self
        purposepicker.dataSource = self
        
        characterpicker.dataSource = self
        characterpicker.delegate = self

    }

 
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == unitpicker{
        return unitsToLoad.count
        }else if pickerView == purposepicker{
            return purposesToLoad.count
        }else{
            return charactersToLoad.count
        }
        
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == unitpicker{
            return unitsToLoad[row]
        }else if pickerView == purposepicker{
            return purposesToLoad[row]
        }else{
            return charactersToLoad[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == unitpicker{
            
            pickerView.isHidden = true
            
            unitBtn.setTitle(unitsToLoad[row], for: UIControlState.normal)
        }else if pickerView == purposepicker{
           
            purposepicker.isHidden = true
            selectpurposebtn.titleLabel?.text = purposesToLoad[row]
            
            
        }else{
            
            characterpicker.isHidden = true
            
            selectcharacterbtn.titleLabel?.text = charactersToLoad[row]
        }
        
        
        
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        
        
        if(self.loadChange.text != "" && self.unitBtn.titleLabel?.text != "Unit" && self.selectpurposebtn.titleLabel?.text != "Select Purpose..." && self.selectcharacterbtn.titleLabel?.text != "Select..." && self.supplyvoltage.text != "" && self.kno.text != ""){
            
            
        let myUrl = URL(string: "http://localhost:8080/project/createrequest.php")
        let request = NSMutableURLRequest(url: myUrl! )
        request.httpMethod = "POST";
        //print(mobno)
            let type : String = "Load Change"
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
    
    


}
