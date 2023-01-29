//
//  WeatherApi.swift
//  WeatherTest
//
//  Created by Golboy on 28/1/2566 BE.
//

import Foundation

class WeatherApi: NSObject {
    let urlName = "https://api.openweathermap.org/data/2.5/"
    let keyAppId = "1f99be0b24c7f63fabba2b1820c02ebb"
    
    func getWeather(city: String, units: String) -> WeatherDto? {
        let urlS = "\(urlName)weather?q=\(city)&appid=\(keyAppId)&lang=th&units=\(units)"
        let request = NSMutableURLRequest()
        request.url = URL(string: urlS)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        let (data, response, error) = URLSession.shared.synchronousDataTask(urlrequest: request as URLRequest)
        
        if error == nil {
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                do {
                    let data = try JSONDecoder().decode(WeatherDto.self, from: data!)
                     //print("|| \(data)")
                    return data
                } catch {
                    print(error)
                    
                }
            }
        }
        return nil
    }
    
    func getForecast(city: String, units: String) -> ForecastDto? {
        let urlS = "\(urlName)forecast?q=\(city)&appid=\(keyAppId)&lang=th&units=\(units)"
        let request = NSMutableURLRequest()
        request.url = URL(string: urlS)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        
        let (data, response, error) = URLSession.shared.synchronousDataTask(urlrequest: request as URLRequest)
        
        if error == nil {
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                do {
                    //print("data :: \(String(data: data!, encoding: .utf8))")
                 
                    let data = try JSONDecoder().decode(ForecastDto.self, from: data!)
                    //print("|| \(data)")
                    return data
                } catch {
                    print(error)
                    
                }
            }
        }
        return nil
    }
}
