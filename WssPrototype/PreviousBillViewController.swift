//
//  PreviousBillViewController.swift
//  RetroCalc
//
//  Created by Mohsin Khan on 03/07/17.
//  Copyright © 2017 Mohsin Khan. All rights reserved.
//

import UIKit
import WebKit

class PreviousBillViewController: UIViewController {

    @IBOutlet weak var pdfview: UIWebView!
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pdfURL = Bundle.main.url(forResource: "bill", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            do {
                let data = try Data(contentsOf: pdfURL)
                let webView = WKWebView(frame: CGRect(x:0,y:80,width:view.frame.size.width, height:view.frame.size.height-40))
                webView.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
                view.addSubview(webView)
                
            }
            catch {
                // catch errors here
            }
            
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
