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
    func setupCell(with day: DailyWeather) {
        dayLabel.text = DateFormatter.dayDateFormattter.string(from: day.date)
        weatherImageView.image = day.weather.first?.image?.withRenderingMode(.alwaysOriginal)
        perceptionLabel.text = day.formattedPrecipitation
        temperatureLabel.text = day.temperature.temperatureWithCelsius
    }
}
