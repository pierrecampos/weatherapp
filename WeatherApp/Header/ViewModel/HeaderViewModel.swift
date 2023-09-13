//
//  HeaderViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 13/09/23.
//

import Foundation

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
    
    
    
    
}
