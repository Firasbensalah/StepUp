//
//  LobbyController.swift
//  StepUp
//
//  Created by admin on 10/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class LobbyController: UIViewController {
static var title = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toAlcohol"){
            LobbyController.title = "Alcohol"
            
        }
        if (segue.identifier == "toDrugs"){
            LobbyController.title = "Drugs"
            
        }
        if (segue.identifier == "toGambling"){
            LobbyController.title = "Gambling"
            
        }
        if (segue.identifier == "toJunk"){
            LobbyController.title = "Food"
            
        }
        if (segue.identifier == "toPorn"){
            LobbyController.title = "Porn"

        }
        if (segue.identifier == "toSmoking"){
            LobbyController.title = "Smoking"
            
        }
        if (segue.identifier == "toSocial"){
            LobbyController.title = "Media"
            
        }
        if (segue.identifier == "toVideo"){
            LobbyController.title = "Games"
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
