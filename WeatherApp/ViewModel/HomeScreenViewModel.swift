//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeScreenViewModel {
    var weatherForecast: WeatherForecastModel?
    var dataSource: WeatherForecastModel?
    
    
    public func fetchWeatherForecast() {
        OpenWeatherApiService.getWeatherForescat { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        
        }
    }
 
}
