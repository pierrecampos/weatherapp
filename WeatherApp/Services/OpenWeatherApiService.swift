//
//  OpenWeatherApiService.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 09/09/23.
//

import Foundation
import UIKit

enum Error: Swift.Error {
    case urlError
    case canNotParseData
}

public class OpenWeatherApiService {
      
    static func getWeatherForecastJson(completionHandler: @escaping (_ result: Result<WeatherForecastModel, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "forecast", withExtension: "json")
        else { return completionHandler(.failure(.urlError))}
        
        do {
            let data = try Data(contentsOf: url)
            let forecast = try JSONDecoder().decode(WeatherForecastModel.self, from: data)
            completionHandler(.success(forecast))
        } catch {
            completionHandler(.failure(.canNotParseData))
        }
    }
   
    static func getWeatherForecast(_ latitude: Double, _ longitude: Double ,completionHandler: @escaping (_ result: Result<WeatherForecastModel, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(Config.apiKey)&lang=pt_br&units=metric"        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            DispatchQueue.main.async {
                if error == nil,
                   let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(WeatherForecastModel.self, from: data) {
                    completionHandler(.success(resultData))
                } else {
                    completionHandler(.failure(.canNotParseData))
                }}            
        }.resume()
    }

}
