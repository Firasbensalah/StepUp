//
//  HistoryController.swift
//  StepUp
//
//  Created by admin on 05/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HistoryController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_addiction_id.count
    }
    var name = UILabel()
    var start = UILabel()
    var end = UILabel()
    var duration = UILabel()
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "historycell")
        let contentView = cell?.viewWithTag(0)
        name = contentView?.viewWithTag(1) as! UILabel
        start = contentView?.viewWithTag(2) as! UILabel
        end = contentView?.viewWithTag(3) as! UILabel
        duration = contentView?.viewWithTag(4) as! UILabel
       
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date4 = arr_addiction_date[indexPath.row]
        let date3 = arr_addiction_dateend[indexPath.row]
        let date2 = formatter.date(from: arr_addiction_dateend[indexPath.row])
        let date1 = formatter.date(from: arr_addiction_date[indexPath.row])
        let index = Calendar.current.dateComponents([.day],from: date1!,to:date2!).day!
        let hours = Calendar.current.dateComponents([.hour],from: date1!,to:date2!).hour! - (24 * index)
        let mins = Calendar.current.dateComponents([.minute],from: date1!,to:date2!).minute! - ((1440 * index) + (60 * hours))
        let secs = Calendar.current.dateComponents([.second],from: date1!,to:date2!).second! - ((86400 * index) + (3600 * hours) + (60 * mins))
        name.text = arr_addiction_name[indexPath.row]
        start.text = "From : \(date4)"
        duration.text = "Duration : \(index) days,\(hours) hours,\(mins) mins,\(secs) secs"
        end.text = " To : \(date3)"
       
        return cell!
    }
    
    var arr_addiction_name = [String]()
    var arr_addiction_id = [String]()
    var arr_addiction_date = [String]()
    var arr_addiction_dateend = [String]()
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mytableview.delegate = self
        self.mytableview.dataSource = self
        getData()
        
        // Do any additional setup after loading the view.
    }
    
    func getData()
    {
        Alamofire.request(ViewController.port+"/cloAddictions/"+ViewController.session).responseString { (response) in
            
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
                  let add_dateend = i["end_time"].stringValue
                              self.arr_addiction_dateend.append(add_dateend)        }
        self.mytableview.reloadData()
           }    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
