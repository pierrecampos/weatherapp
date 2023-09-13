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
    
    public func loadCurrentWeatherForecast(_ indexPath: IndexPath) -> WeatherForecast {
        return dataSource.list[indexPath.row]
    }
    
    public func fetchWeatherForecast() {
        OpenWeatherApiService.getWeatherForecastJson { [weak self] result in
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
