//
//  StatController.swift
//  StepUp
//
//  Created by admin on 09/05/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Charts
import Alamofire
class StatController: UIViewController {

    @IBOutlet weak var pieChart: PieChartView!
    
 let noZeroFormatter = NumberFormatter()
    var VideoGames = PieChartDataEntry(value: 0)
    var alcohol = PieChartDataEntry(value: 0)
    var drugs = PieChartDataEntry(value: 0)
    var Gambling = PieChartDataEntry(value: 0)
    var JunkFood = PieChartDataEntry(value: 0)
    var Porn = PieChartDataEntry(value: 0)
    var Smoking = PieChartDataEntry(value: 0)
    var SocialMedia = PieChartDataEntry(value: 0)
    var nbVG = 0
    var nbalc = 0
    var nbdrugs = 0
    var nbgamb = 0
    var nbjf = 0
    var nbpo = 0
    var nbsmo = 0
    var nbsm = 0
    
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    var gTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
         Alamofire.request(ViewController.port+"/VideoGames/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                      
                    self.nbVG = data["res_Count"] as! Int
                  
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
        
        Alamofire.request(ViewController.port+"/Alcohol/"+ViewController.session).responseJSON { response in
            if response.result.isSuccess {
                
            
            guard let data = response.result.value as? [String: Any] else { return }
             
            
             self.nbalc = data["res_Count"] as! Int
        
             self.updateChartData()
                
                
               
               
            }else{
                print("Error")
            }
        }
        
         
               Alamofire.request(ViewController.port+"/Drugs/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbdrugs = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
         
               Alamofire.request(ViewController.port+"/Gambling/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbgamb = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
        
         
               Alamofire.request(ViewController.port+"/JunkFood/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbjf = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
        
         
               Alamofire.request(ViewController.port+"/Porn/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbpo = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                  
                }
               }
        
         
               Alamofire.request(ViewController.port+"/Smoking/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbsmo = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
        
         
               Alamofire.request(ViewController.port+"/SocialMedia/"+ViewController.session).responseJSON { response in
                   if response.result.isSuccess {
                       
                   
                   guard let data = response.result.value as? [String: Any] else { return }
                    
                   
                    self.nbsm = data["res_Count"] as! Int
               
                    self.updateChartData()
                       
                       
                      
                      
                   }else{
                       print("Error")
                   }
               }
        
        
        noZeroFormatter.zeroSymbol = ""
        pieChart.chartDescription?.text = ""
        pieChart.holeColor = UIColor.black
        pieChart.transparentCircleColor = UIColor.black
        pieChart.legend.textColor = UIColor.white
        pieChart.legend.font = UIFont(name: "Verdana", size: 20)!
        pieChart.legend.formSize = 20
        pieChart.legend.enabled = false
        gTimer = Timer.scheduledTimer(timeInterval: 0.5,target: self, selector: #selector(runTimedCode),userInfo: nil, repeats: true)
        
    }
 
@objc func runTimedCode() {
        if(nbalc > 0){
            alcohol.value = Double(nbalc)
            alcohol.label = "Alcohol"
            
        }else{
           
            alcohol.label = ""
        }
        
        if(nbdrugs > 0){
            drugs.value = Double(nbdrugs)
            drugs.label = "Drugs"
            
        }else{
            
            drugs.label = ""
        }
        
        if(nbgamb > 0){
            Gambling.value = Double(nbgamb)
            Gambling.label = "Gambling"
            
        }else{
         
            Gambling.label = ""
        }
        
        if(nbjf > 0){
            JunkFood.value = Double(nbjf)
            JunkFood.label = "Junk Food"
            
        }else{
         
            JunkFood.label = ""
        }
        
        if(nbpo > 0){
            Porn.value = Double(nbpo)
            Porn.label = "Porn"
            
        }else{
           
            Porn.label = ""
        }
        
        if(nbsmo > 0){
            Smoking.value = Double(nbsmo)
            Smoking.label = "Smoking"
            
        }else{
            
           Smoking.label = ""
        }
        
        if(nbsm > 0){
            SocialMedia.value = Double(nbsm)
            SocialMedia.label = "Social Media"
            
        }else{
         
            SocialMedia.label = ""
        }
        
        if(nbVG > 0){
            VideoGames.value = Double(nbVG)
            VideoGames.label = "Video Games"
            
        }else{
         
            VideoGames.label = ""
        }
                
                
             numberOfDownloadsDataEntries = [alcohol,drugs,Gambling,JunkFood,Porn,Smoking,SocialMedia,VideoGames]
           
        updateChartData()    }
    
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        var colors : [UIColor] = []
        colors.append(UIColor.red)
        colors.append(UIColor.blue)
        colors.append(UIColor.purple)
        colors.append(UIColor.darkGray)
        colors.append(UIColor.systemTeal)
        colors.append(UIColor.magenta)
        colors.append(UIColor.brown)
        colors.append(UIColor.systemIndigo)
        chartDataSet.colors = colors
        chartDataSet.valueFont = UIFont(name: "Verdana", size: 30)!
        chartDataSet.valueFormatter = DefaultValueFormatter(formatter: noZeroFormatter)
        pieChart.data = chartData
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
