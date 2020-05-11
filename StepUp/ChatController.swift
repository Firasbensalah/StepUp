//
//  ChatController.swift
//  StepUp
//
//  Created by admin on 10/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ChatController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return arr_chat_pseudo.count
     }
    
     
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = mytableview.dequeueReusableCell(withIdentifier: "cell")
         let contentView = cell?.viewWithTag(0)
        let  name = contentView?.viewWithTag(1) as! UILabel
        let msg = contentView?.viewWithTag(2) as! UITextView
        name.text = arr_chat_pseudo[indexPath.row]+"("+arr_chat_title[indexPath.row]+")"
        msg.text = arr_chat_message[indexPath.row]
    
        
         return cell!
     }
    var arr_chat_pseudo = [String]()
    var arr_chat_title = [String]()
    var arr_chat_message = [String]()
    @IBOutlet weak var titl: UILabel!
   var gTimer: Timer?
    @IBOutlet weak var msginput: UITextField!
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titl.text = "Chat Room : "+LobbyController.title
         self.mytableview.delegate = self
                   self.mytableview.dataSource = self
        gTimer = Timer.scheduledTimer(timeInterval: 0.5,target: self, selector: #selector(runTimedCode),userInfo: nil, repeats: true)        // Do any additional setup after loading the view.
    }
    @IBAction func msg(_ sender: Any) {
        let parameters: [String: Any] = [
            "pseudo" : ViewController.session,
            "title" : HomeController.Title,
            "message" : msginput.text!,
            "room" : LobbyController.title
        ]
        
        Alamofire.request(ViewController.port+"/chat/add", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON{ response in

        }
        msginput.text = ""
    }
    
     @objc func runTimedCode(){
          
               
               self.getData()
                self.mytableview.reloadData()
               
                                  
          
           
       }
    func getData()
    {
        Alamofire.request(ViewController.port+"/chat/"+LobbyController.title).responseString { (response) in
            
            let myresult = try? JSON(data: response.data!)
            if ( myresult != nil){
        self.arr_chat_pseudo.removeAll()
        self.arr_chat_title.removeAll()
            self.arr_chat_message.removeAll()
            
            for i in myresult!.arrayValue  {
                let add_id = i["pseudo"].stringValue
                self.arr_chat_pseudo.append(add_id)
            let add_name = i["title"].stringValue
            self.arr_chat_title.append(add_name)
                let chat_msg = i["message"].stringValue
                self.arr_chat_message.append(chat_msg)
                     }
        self.mytableview.reloadData()
           }
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
