//
//  RequestManager.swift
//  Weather
//
//  Created by Matúš Mištrik on 23/04/2022.
//

import Foundation
import CoreLocation
import Alamofire


struct RequestManager {
    static let shared = RequestManager()
    
    func getWeatherData(for coordinates: CLLocationCoordinate2D, completion: @escaping (Result<WeatherResponse, AFError>) -> Void) {
        let request = WeatherRequest(latitude: "\(coordinates.latitude)",
                                     longitude: "\(coordinates.longitude)",
                                     exclude: "hourly,minutely,alerts",
                                     appId: "your_api_token",
                                     units: "metric")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        AF.request("https://api.openweathermap.org/data/2.5/onecall", method: .get, parameters: request)
            .validate()
            .responseDecodable(of: WeatherResponse.self, decoder: decoder) { completion($0.result) }
    }
    
}
