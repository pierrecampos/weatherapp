//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

protocol HomeScreenViewModelDelegate: AnyObject {
    func successFetchData()
}

class HomeScreenViewModel {
    
    public weak var delegate: HomeScreenViewModelDelegate?
    
    var dataSource = WeatherForecastModel(list: [])
    
    var numberOfRows: Int {
        return dataSource.list.count
    }
    
    public func fetchWeatherForecast() {
        OpenWeatherApiService.getWeatherForescat { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.delegate?.successFetchData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}
