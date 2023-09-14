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
    var wind: Wind
    var pop: Double
}

struct Main: Codable {
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var humidity: Double
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

struct Weather: Codable {
    var id: Int
    var description: String
    var icon: String
    var iconUrl: String {
        return "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}

struct Wind: Codable {
    var speed: Double
}


