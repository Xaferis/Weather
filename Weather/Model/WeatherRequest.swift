//
//  WeatherRequest.swift
//  Weather
//
//  Created by Matúš Mištrik on 23/04/2022.
//

import Foundation

struct WeatherRequest: Encodable {
    
    let latitude: String
    let longitude: String
    let exclude: String
    let appId: String
    let units: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case appId = "appid"
        case units, exclude
    }
}
