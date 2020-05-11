//
//  ArticleItemController.swift
//  StepUp
//
//  Created by admin on 08/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
class ArticleItemController: UIViewController {
    var id = ""
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var tit: UILabel!
    @IBOutlet weak var des: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       Alamofire.request(ViewController.port+"/Article/"+id).responseJSON { response in
            if response.result.isSuccess {
                
            
            guard let data = response.result.value as? [[String: Any]] else { return }
               
            guard let titre = data[0]["title"] as? String else { return }
                guard let desc = data[0]["description"] as? String else { return }
                guard let dat = data[0]["date"] as? String else { return }
                self.tit.text = titre
                self.des.text = desc
                self.date.text = dat
               
            }else{
                print("Error")
            }
        }
        // Do any additional setup after loading the view.
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
