//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Talha Varol on 19.03.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getRatesClicked(_ sender: Any) {
        
        //1 request veya session internete gitmek.
        //2 Response veya datayı almak
        //3 Parsing json serialization veriyi işlemek.
        
        let url = URL(string:"http://data.fixer.io/api/latest?access_key=33b89c2632700f0a026d924f967d93f8")
        let sessions = URLSession.shared
        
        let task = sessions.dataTask(with: url!) { (data, response, eror) in
            if eror != nil{
                
                let alert = UIAlertController(title: "Eror", message: eror?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                
                alert.addAction(okButton)
                
                self.present(alert, animated: true, completion: nil)
            }else{
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        // apiden çekilen veri başka theardda olmalı...
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                if let cad = rates["CAD"] as? Double{
                                    self.cadLabel.text = ("Cad: \(cad)")
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.chfLabel.text = ("CHF: \(chf)")
                                }
                                if let tr = rates["TRY"] as? Double{
                                    self.tryLabel.text = ("🇹🇷TRY🇹🇷: \(tr)")
                                }
                                if let usd = rates["USD"] as? Double{
                                    self.usdLabel.text = ("USD: \(usd)")
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.jpyLabel.text = ("JPY: \(jpy)")
                                }
                            }
                                
                        }
                }catch{
                    print("Eror!")
                }
              }
            }
            
        }
        task.resume()
       
    }
    
}

