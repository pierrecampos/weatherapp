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
    var dt: Int
    var main: Main
    var weather: [Weather]
}

struct Main: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Codable {
    var description: String
    var icon: String
}


