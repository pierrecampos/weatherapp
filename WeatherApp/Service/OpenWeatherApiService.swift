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
   
    static func getWeatherForescat(completionHandler: @escaping (_ result: Result<WeatherForecastModel, Error>) -> Void) {
        let urlString = "https://run.mocky.io/v3/cf4a2eeb-e732-412e-9010-c55d70214f38"        
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
    
    static func getImageFromUrl(urlString: String, completionHandler: @escaping (_ result: Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
            DispatchQueue.main.async {
                if error == nil,
                   let data = dataResponse,
                   let image = UIImage(data: data) {
                    completionHandler(.success(image))
                } else {
                    completionHandler(.failure(.canNotParseData))
                }
            }
        }.resume()
                
    }
}
