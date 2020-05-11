//
//  HomeController.swift
//  StepUp
//
//  Created by admin on 04/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_addiction_id.count
    }
    var name = UILabel()
    var counter = UILabel()
    var time = UILabel()
    var btnreset = UIButton()
    var isPaused = false
    
    static var Title = ""
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = mytableview.dequeueReusableCell(withIdentifier: "mycell")
        let contentView = cell?.viewWithTag(0)
        name = contentView?.viewWithTag(1) as! UILabel
        counter = contentView?.viewWithTag(2) as! UILabel
        time = contentView?.viewWithTag(3) as! UILabel
       
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date3 = Date()
        let modifiedDate = Calendar.current.date(byAdding: .hour, value: -1, to: date3)!
        let Cdate = formatter.string(from: modifiedDate)
        
        let date2 = formatter.date(from: Cdate)
        let date1 = formatter.date(from: arr_addiction_date[indexPath.row])
        let index = Calendar.current.dateComponents([.day],from: date1!,to:date2!).day!
        let hours = Calendar.current.dateComponents([.hour],from: date1!,to:date2!).hour! - (24 * index)
        let mins = Calendar.current.dateComponents([.minute],from: date1!,to:date2!).minute! - ((1440 * index) + (60 * hours))
        let secs = Calendar.current.dateComponents([.second],from: date1!,to:date2!).second! - ((86400 * index) + (3600 * hours) + (60 * mins))
        name.text = arr_addiction_name[indexPath.row]
        counter.text = "\(index) Days"
        time.text = "\(hours)H:\(mins)M:\(secs)S"
      
        if (index > 359){
            HomeController.Title = "Elite"
 
        } else if(index > 179) {
            HomeController.Title = "Grandmaster"
            
        } else if(index > 89) {
            HomeController.Title = "Master"
            
        }else if(index > 29) {
            HomeController.Title = "Resilient Guy"
            
        }else if(index > 13) {
            HomeController.Title = "Apprentice"
            
        }else if(index > 6) {
            HomeController.Title = "Firm Believer"
            
        }else if(index > 2) {
            HomeController.Title = "Cool Guy"
            
        }else{
            HomeController.Title = "New Guy"
            
        }
       
        return cell!
    }
    
     func tableView(_ tableView: UITableView,
      editActionsForRowAt indexPath: IndexPath)
      -> [UITableViewRowAction]? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0,execute: {
            self.reset()
        })
        isPaused = true
      let deleteTitle = NSLocalizedString("Delete", comment: "Delete action")
      let deleteAction = UITableViewRowAction(style: .destructive,
        title: deleteTitle) { (action, indexPath) in
            Alamofire.request(ViewController.port+"/addiction/delete/"+self.arr_addiction_id[indexPath.row],method: .delete)
                .responseJSON{ response in
                
            }
            self.getData()
             self.mytableview.reloadData()
            self.isPaused = false
      }

      let favoriteTitle = NSLocalizedString("Reset", comment: "Favorite action")
      let favoriteAction = UITableViewRowAction(style: .normal,
        title: favoriteTitle) { (action, indexPath) in
            
            let parameters: [String: Any] = [
                "pseudo" : ViewController.session,
                "addiction_name" : self.arr_addiction_name[indexPath.row]
            ]
              Alamofire.request(ViewController.port+"/addiction/add", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                            .responseJSON{ response in
                               
                        }
            
            Alamofire.request(ViewController.port+"/resetAddiction/"+self.arr_addiction_id[indexPath.row],method: .put)
                                                  .responseJSON{ response in
                                                 
                                                   
                                   }
            
           
           
            
        }
        
        deleteAction.backgroundColor = .black
      favoriteAction.backgroundColor = .black
      return [favoriteAction, deleteAction]
    }
    var arr_addiction_name = [String]()
    var arr_addiction_id = [String]()
    var arr_addiction_date = [String]()
     var choices = ["Alcohol","Drugs","Gambling","Junk Food","Porn","Smoking","Social Media","Video Games"]
       var pickerView = UIPickerView()
       var typeValue = String()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func reset(){
        isPaused = false
    }
     
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            typeValue = "Alcohol"
        } else if row == 1 {
            typeValue = "Drugs"
        } else if row == 2 {
            typeValue = "Gambling"
        } else if row == 3 {
            typeValue = "Junk Food"
        } else if row == 4 {
            typeValue = "Porn"
        } else if row == 5 {
            typeValue = "Smoking"
        } else if row == 6 {
            typeValue = "Social Media"
        } else if row == 7 {
            typeValue = "Video Games"
        }
    }
    
  var username = ""
    var gTimer: Timer?
    @IBOutlet weak var mytableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        HomeController.Title = "New Guy"
        self.mytableview.delegate = self
        self.mytableview.dataSource = self
        gTimer = Timer.scheduledTimer(timeInterval: 0.5,target: self, selector: #selector(runTimedCode),userInfo: nil, repeats: true)
        getData()
        // Do any additional setup after loading the view.
    }
    @objc func runTimedCode(){
        if (isPaused == false){
            
            self.getData()
                         self.mytableview.reloadData()
            
                               }
       
        
    }
   
    func getData()
    {
        Alamofire.request(ViewController.port+"/actAddictions/"+ViewController.session).responseString { (response) in
            
            let myresult = try? JSON(data: response.data!)
        
        self.arr_addiction_name.removeAll()
        self.arr_addiction_id.removeAll()
            self.arr_addiction_date.removeAll()
        
            for i in myresult!.arrayValue  {
                let add_id = i["addiction_id"].stringValue
                self.arr_addiction_id.append(add_id)
            let add_name = i["addiction_name"].stringValue
            self.arr_addiction_name.append(add_name)
                let add_date = i["start_time"].stringValue
                self.arr_addiction_date.append(add_date)
        }
        self.mytableview.reloadData()
           }    }
    
    func alert(){
        let alertController = UIAlertController(title: "Warning", message:
            "Addiction already exists", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func Add(_ sender: Any) {
        let alert = UIAlertController(title: "Add Addiction", message: "\n\n\n\n\n\n", preferredStyle: .alert)
            alert.isModalInPopover = true
            
            let pickerFrame = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            
            alert.view.addSubview(pickerFrame)
            pickerFrame.dataSource = self
            pickerFrame.delegate = self
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                if (self.arr_addiction_name.contains(self.typeValue)){
                    
                    self.alert()
                    
                    
                    
                }else{
                    let parameters: [String: Any] = [
                        "pseudo" : ViewController.session,
                        "addiction_name" : self.typeValue
                    ]
                    
                    Alamofire.request(ViewController.port+"/addiction/add", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON{ response in
                            self.getData()
                    }
                }
                
                
                
            }))
            self.present(alert,animated: true, completion: nil )
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
