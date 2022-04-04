//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Matúš Mištrik on 04/04/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    static var classString: String {
        String(describing: WeatherTableViewCell.self)
    }

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
}
