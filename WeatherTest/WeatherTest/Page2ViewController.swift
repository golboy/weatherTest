//
//  Page2ViewController.swift
//  WeatherTest
//
//  Created by Golboy on 28/1/2566 BE.
//

import UIKit

class Page2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{
    
    
    var city = ""
    var unit = ""
    var dataList : ForecastDto? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Forecast: \(self.city)"
        
        self.dataList = WeatherApi().getForecast(city: self.city, units: self.unit)
        //print("data \(dataList?.list.count ?? 0)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ForecastTableViewCell = tableView.dequeueReusableCell(withIdentifier: "fcTvcell", for: indexPath) as! ForecastTableViewCell
        cell.dateFc.text = self.dataList?.list[(indexPath as NSIndexPath).row].dtTxt
        if self.unit == "metric" {
            cell.tempFc.text = (NSString(format: "%.2f",self.dataList!.list[(indexPath as NSIndexPath).row].main.temp) as String)+" C°"
        } else {
            cell.tempFc.text = (NSString(format: "%.2f",self.dataList!.list[(indexPath as NSIndexPath).row].main.temp) as String) + " F°"
        }
        cell.huFc.text = String(self.dataList!.list[(indexPath as NSIndexPath).row].main.humidity)
        
        if let url = URL(string: "https://openweathermap.org/img/wn/\(self.dataList!.list[(indexPath as NSIndexPath).row].weather[0].icon)@2x.png") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    cell.imgFc.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
        
        return cell
    }

}
