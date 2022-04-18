//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Matúš Mištrik on 04/04/2022.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {
    
    // MARK: - Static
    
    static var classString: String { String(describing: WeatherDayTableViewCell.self) }
    
    // MARK: - Outlets

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var perceptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
}


// MARK: - Public
extension WeatherDayTableViewCell {
    func setupCell(with day: ForecastDay) {
        dayLabel.text = day.title
        weatherImageView.image = day.state.icon?.withRenderingMode(.alwaysOriginal)
        perceptionLabel.text = day.perceptionPercentage
        temperatureLabel.text = day.temperatureInCelsius
    }
}
