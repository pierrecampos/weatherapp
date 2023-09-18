//
//  HomeScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

enum WeatherIconEnum: String {
    case thunderstorm = "cloud.bolt.rain.fill"
    case drizzle = "cloud.drizzle.fill"
    case rain = "cloud.heavyrain.fill"
    case snow = "cloud.snow.fill"
    case clear = "sun.max.fill"
    case clouds = "cloud.fill"
    case other = "sun.haze.fill"
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func successFetchData()
}

class HomeScreenViewModel {
    
    public weak var delegate: HomeScreenViewModelDelegate?
    
    private var dataSource = WeatherForecastModel(list: [])
    
    
    var numberOfRows: Int {
        return dataSource.singleDays.count
    }
    
    public func loadCurrentWeatherForecast(_ indexPath: IndexPath) -> WeatherForecast {
        return dataSource.singleDays[indexPath.item]
    }
    
    public func fetchWeatherForecast() {
        OpenWeatherApiService.getWeatherForecast { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.delegate?.successFetchData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func getTemperature(_ index: Int) -> String {
        return String(format:"%.0f", dataSource.singleDays[index].main.temp)
    }
    
    public func getMinTemperature(_ index: Int) -> String  {
        let minValue = String(format:"%.0f", dataSource.singleDays[index].main.tempMin)
        return "Min: \(minValue)°"
    }
    
    public func getMaxTemperature(_ index: Int) -> String {
        let maxValue = String(format:"%.0f", dataSource.singleDays[index].main.tempMax)
        return "Máx: \(maxValue)°"
    }
    
    public func getDayAndDate(_ index: Int) -> String {
        let date = Date(timeIntervalSince1970: dataSource.singleDays[index].dt)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "EEEE, dd"
        
        return dateFormatter.string(from: date).capitalized
    }
    
    public func getTemperatureImage(_ index: Int) -> UIImage {
        let iconName = self.getIconForecast(of: dataSource.singleDays[index].weather[0].id)
        return  UIImage(systemName: iconName)!.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(.secondary)
    }
    
    public func getDayDescription(_ index: Int) -> String {
        return dataSource.singleDays[index].weather[0].description.capitalized
    }
    
    public func getProbabilityPrecipitation(_ index: Int) -> String {
        let preciptation = dataSource.singleDays[index].pop * 100
        return String(format: "%.0f%%", preciptation)
    }
    
    public func getWindSpeed(_ index: Int) -> String {
        let speed = dataSource.singleDays[index].wind.speed * 3.6
        return String(format: "%.0f km/h", speed)
    }
    
    public func getHumidity(_ index: Int) -> String {
        return String(format: "%.0f%%",dataSource.singleDays[index].main.humidity)
    }
    
    // Code Icons https://openweathermap.org/weather-conditions
    private func getIconForecast(of id: Int) -> String {
        switch id {
        case 200...232:
            return WeatherIconEnum.thunderstorm.rawValue
        case 300...321:
            return WeatherIconEnum.drizzle.rawValue
        case 500...531:
            return WeatherIconEnum.rain.rawValue
        case 600...622:
            return WeatherIconEnum.snow.rawValue
        case 800:
            return WeatherIconEnum.clear.rawValue
        case 801...804:
            return WeatherIconEnum.clouds.rawValue
        default:
            return WeatherIconEnum.other.rawValue
        }
    }
    
    
}
