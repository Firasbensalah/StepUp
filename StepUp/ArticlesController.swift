//
//  ArticlesController.swift
//  StepUp
//
//  Created by admin on 08/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import Alamofire
import SwiftyJSON
class ArticlesController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_article_id.count
    }
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "cell")
        let contentView = cell?.viewWithTag(0)
       let  name = contentView?.viewWithTag(1) as! UILabel
       
        name.text = arr_article_name[indexPath.row]
   
       
        return cell!
    }
    var gtimer : Timer?
    var arr_article_name = [String]()
    var arr_article_id = [String]()
    @IBOutlet weak var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://www.recovery.org/voices/feed/?x=1").responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.value {
                /// Do something with your new RSSFeed object!
                for item in feed.items {
                   
                    
                    var res = ""
                    var count = 0
                    for c in item.content! {
                        switch c {
                        case "<": count+=1; break;
                        case ">": count-=1; break;
                        default:
                            if count == 0 {
                                res += String(c)
                            }
                            break;
                        }
                    }
                    
                    let datec = item.pubDate?.description.replacingOccurrences(of: "+0000", with: "")
                    
                    let parameters: [String: Any] = [
                        "title" : item.title!,
                        "description" : res,
                        "date" : datec
                    ]
                    
                    Alamofire.request(ViewController.port+"/article/add", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON{ response in

                    }
                  
                    
                }
            }
        }        // Do any additional setup after loading the view.
    self.mytableview.delegate = self
            self.mytableview.dataSource = self
            gtimer = Timer.scheduledTimer(timeInterval: 0.5,target: self, selector: #selector(runTimedCode),userInfo: nil, repeats: true)
            
            // Do any additional setup after loading the view.
        }
    
    
    @objc func runTimedCode(){
       
            
            self.getData()
                         self.mytableview.reloadData()
            
                               
       
        
    }
    
    
    
        func getData()
        {
            Alamofire.request(ViewController.port+"/Articles").responseString { (response) in
                
                let myresult = try? JSON(data: response.data!)
            
            self.arr_article_name.removeAll()
            self.arr_article_id.removeAll()
                
                for i in myresult!.arrayValue  {
                    let add_id = i["id"].stringValue
                    self.arr_article_id.append(add_id)
                let add_name = i["title"].stringValue
                self.arr_article_name.append(add_name)
                         }
            self.mytableview.reloadData()
               }    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        performSegue(withIdentifier:"toDetails", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier == "toDetails"){
            let indexPath = sender as! IndexPath
        let indice = indexPath.row
        let dvc = segue.destination as! ArticleItemController
        dvc.id = arr_article_id[indice]
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
