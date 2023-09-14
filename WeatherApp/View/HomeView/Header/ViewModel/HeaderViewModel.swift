//
//  HeaderViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 13/09/23.
//

import Foundation
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

class HeaderViewModel {
    private var weatherForecast: WeatherForecast
    
    init(_ weatherForecast: WeatherForecast) {
        self.weatherForecast = weatherForecast
    }
    
    public var getTemperature: String {
        return String(format:"%.0f", weatherForecast.main.temp)
    }
    
    public var getMinTemperature: String {
        let minValue = String(format:"%.0f", weatherForecast.main.tempMin)
        return "Min: \(minValue)°"
    }
    
    public var getMaxTemperature: String {
        let maxValue = String(format:"%.0f", weatherForecast.main.tempMax)
        return "Máx: \(maxValue)°"
    }
    
    public var getDayAndDate: String {
        let date = Date(timeIntervalSince1970: weatherForecast.dt)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "EEEE, dd"
        
        return dateFormatter.string(from: date).capitalized
    }
    
    public var getTemperatureImage: UIImage {
        let iconName = self.getIconForecast(of: weatherForecast.weather[0].id)
        return  UIImage(systemName: iconName)!.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(.secondary)
    }
    
    public var getDayDescription: String {
        return weatherForecast.weather[0].description.capitalized
    }
    
    public var getProbabilityPrecipitation: String {
        let preciptation = weatherForecast.pop * 100
        return String(format: "%.0f%%", preciptation)
    }
    
    public var getWindSpeed: String {
        let speed = weatherForecast.wind.speed * 3.6
        return String(format: "%.0f km/h", speed)
    }
    
    public var getHumidity: String {
        return String(format: "%.0f%%", weatherForecast.main.humidity)
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
