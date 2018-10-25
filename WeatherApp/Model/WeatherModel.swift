//
//  File.swift
//  WeatherApp
//
//  Created by Bartomiej Łaski on 14/10/2018.
//  Copyright © 2018 Bartomiej Łaski. All rights reserved.
//

import Foundation

struct WeatherModel
{
    var cityName: String
    var Temp: Double
    var Pressure: Double
    var TempMin: Double
    var TempMax: Double
    var lon: Double
    var lat: Double
}

extension WeatherModel: Decodable
{
    enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case main = "main"
        case coords = "coord"
        case temp = "temp"
        case pressure = "pressure"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case lon = "lon"
        case lat = "lat"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cityName = try container.decode(String.self, forKey: .cityName)
        
        let main = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .main)
        Temp = try main.decode(Double.self, forKey: .temp)
        Pressure = try main.decode(Double.self, forKey: .pressure)
        TempMin = try main.decode(Double.self, forKey: .tempMin)
        TempMax = try main.decode(Double.self, forKey: .tempMax)
        
        let coords = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .coords)
        lon = try coords.decode(Double.self, forKey: .lon)
        lat = try coords.decode(Double.self, forKey: .lat)
    }
}
