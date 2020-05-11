//
//  RegisterControllerViewController.swift
//  StepUp
//
//  Created by admin on 03/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire

class RegisterControllerViewController: UIViewController {

    @IBOutlet weak var Fname: UITextField!
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Pass: UITextField!
    var isReady = false
    
     override func viewDidLoad() {
           super.viewDidLoad()
           isReady = false
               
           }
   
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "toHome" {
            if (isReady == true){
                return true
            }
        }
        
        if identifier == "toSign" {
            return true
        }
        return false
    }
    
    @IBAction func SignUp(_ sender: Any) {
        
        if ((Uname.text?.isEmpty)! || (Lname.text?.isEmpty)! || (Uname.text?.isEmpty)! || (Pass.text?.isEmpty)! ){
            let alertController = UIAlertController(title: "Incomplete Values", message:
                "There are incomplete fields in your submission", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))

            self.present(alertController, animated: true, completion: nil)
        }else{
            isReady = true
            let parameters: [String: Any] = [
                "pseudo" : Uname.text,
                "first_name" : Fname.text,
                "last_name" : Lname.text,
                "password" : Pass.text
            ]
            
            Alamofire.request(ViewController.port+"/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON{ response in

            }
            
        }
        
        
    }
           // Do any additional setup after loading the view.
    }
    

    


