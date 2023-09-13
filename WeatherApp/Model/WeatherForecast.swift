//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

struct WeatherForecastModel: Codable {
    var list: [WeatherForecast]
}

struct WeatherForecast: Codable {
    var dt: Double
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Weather: Codable {
    var description: String
    var icon: String
    var iconUrl: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}


