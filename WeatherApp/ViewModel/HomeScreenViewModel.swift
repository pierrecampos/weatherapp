//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

protocol HomeScreenViewModelDelegate: AnyObject {
    func successFetchData(_ data: WeatherForecastModel)
}

class HomeScreenViewModel {
    
    public weak var delegate: HomeScreenViewModelDelegate?
    
    var dataSource: WeatherForecastModel?
    
    public func fetchWeatherForecast() {
        OpenWeatherApiService.getWeatherForescat { [weak self] result in
            switch result {
            case .success(let data):
                self?.delegate?.successFetchData(data)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
