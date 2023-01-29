//
//  ViewController.swift
//  WeatherTest
//
//  Created by Golboy on 28/1/2566 BE.
//

import UIKit

class ViewController: UIViewController {
    var data : WeatherDto? = nil
    var units: String = "metric" //metric = C° , imperial = F°
    //    https://openweathermap.org/img/wn/01d@2x.png
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var temperatureLb: UILabel!
    @IBOutlet weak var humidityLb: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var unitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Current Weather"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Forecast", style: .done, target: self, action: #selector(self.action(sender:)))
        self.cityTxt.text = "Bangkok"
        getDataApi()
        
        //        print("eiei2 \(WeatherApi().getForecast(city: "Bangkok", units: units))")
    }
    
    func getDataApi(){
        self.data = WeatherApi().getWeather(city: self.cityTxt.text ?? "", units: units)
        if self.data != nil {
            if self.units == "metric" {
                self.temperatureLb.text = (NSString(format: "%.2f",data!.main.temp) as String)+" C°"
            } else {
                self.temperatureLb.text = (NSString(format: "%.2f",data!.main.temp) as String) + " F°"
            }
            self.humidityLb.text = "\(data!.main.humidity)"
            
            if let url = URL(string: "https://openweathermap.org/img/wn/\(data!.weather[0].icon)@2x.png") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async {
                        self.icon.image = UIImage(data: data)
                    }
                }
                
                task.resume()
            } else {
                self.icon.image = UIImage(contentsOfFile: "")
            }
        } else {
            self.temperatureLb.text = ""
            self.humidityLb.text = ""
            self.icon.image = UIImage(contentsOfFile: "")
        }
        
        if self.units == "metric" {
            self.unitBtn.setTitle("To F°", for: UIControl.State())
        } else {
            self.unitBtn.setTitle("To C°", for: UIControl.State())
        }
    }
    
    
    @IBAction func changeTmp(_ sender: Any) {
        if self.units == "metric" {
            self.units = "imperial"
        } else {
            self.units = "metric"
        }
        getDataApi()
    }
    
    @objc func action(sender: UIBarButtonItem) {
        if self.data != nil {
            print("action to forecast")
            let goToPage2 = self.storyboard?.instantiateViewController(withIdentifier: "page2") as! Page2ViewController
            goToPage2.city = self.cityTxt.text!
            goToPage2.unit = self.units
            self.navigationController?.pushViewController(goToPage2, animated: true)
        } else {
            alertErr()
        }
    }
    
    func alertErr(){
        let alert = UIAlertController(title: "Please enter the correct city.", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { action in
            print("Click on data nil")
        }
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

