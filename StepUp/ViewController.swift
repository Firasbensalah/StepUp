//
//  ViewController.swift
//  StepUp
//
//  Created by user168906 on 4/9/20.
//  Copyright © 2020 user168906. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pass: UITextField!
    var username = ""
    static var session = ""
    static var port = "stepupios.eu-4.evennode.com"
    override func viewDidLoad() {
       
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func Login(_ sender: Any) {
        let parameters: [String: Any] = [
            "pseudo" : Uname.text,
            "password" : Pass.text
        ]
        var statusCode: Int = 0
        Alamofire.request(ViewController.port+"/authenticate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{ response in
                statusCode = (response.response?.statusCode)!
                if(statusCode == 201){
                    self.username = self.Uname.text!
                    self.performSegue(withIdentifier: "login", sender: self)
                }else{
                    let alertController = UIAlertController(title: "Warning", message:
                           "Login failed: Invalid username or password", preferredStyle: .alert)
                       alertController.addAction(UIAlertAction(title: "Ok", style: .default))

                       self.present(alertController, animated: true, completion: nil)
                }
                
        }
                
              
                
                
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "login"){
            ViewController.session = self.username
            var vc = segue.destination as! HomeController
            vc.username = self.username        }
        
        
    }
}
    


