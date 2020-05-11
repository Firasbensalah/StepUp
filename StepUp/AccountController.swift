//
//  AccountController.swift
//  StepUp
//
//  Created by admin on 04/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
class AccountController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_addiction_name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.viewWithTag(0)
        let name = contentView?.viewWithTag(1) as! UILabel
        let date = contentView?.viewWithTag(2) as! UILabel
        name.text = arr_addiction_name[indexPath.row]
        date.text = arr_addiction_date[indexPath.row]
        
        return cell!
    }
    
    var arr_addiction_name = ["New Guy","Cool Guy","Firm Believer","Apprentice","Resilient Guy","Master","Grandmaster","Elite"]
    var arr_addiction_date = ["0 Days","3 Days","7 Days","14 Days","30 Days","90 Days","180 Days","360 Days"]
    
    
  static var achi = ""
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var titl: UILabel!
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mytableview.delegate = self
        self.mytableview.dataSource = self
    
        
        
        Alamofire.request(ViewController.port+"/user/"+ViewController.session).responseJSON { response in
            if response.result.isSuccess {
                
            
            guard let data = response.result.value as? [[String: Any]] else { return }
                print(data)
            guard let lname = data[0]["last_name"] as? String else { return }
                guard let fname = data[0]["first_name"] as? String else { return }
                
                
                
                self.Name.text = fname + " " + lname
                self.titl.text = HomeController.Title
               
            }else{
                print("Error")
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
}
