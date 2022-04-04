//
//  ViewController.swift
//  Weather
//
//  Created by Matúš Mištrik on 28/03/2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    struct DayWeather {
        let day: String
        let weather: String
        let humidity: String
        let temperature: String
    }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherStruct: [DayWeather] {
        [DayWeather(day: "Monday", weather: "Sun", humidity: "40%", temperature: "22C"),
         DayWeather(day: "Tuesday", weather: "Sun", humidity: "30%", temperature: "23C"),
         DayWeather(day: "Wednesday", weather: "Rain", humidity: "70%", temperature: "19C"),
         DayWeather(day: "Thursday", weather: "Sun", humidity: "40%", temperature: "20C"),
         DayWeather(day: "Friday", weather: "Rain", humidity: "65%", temperature: "18C"),
         DayWeather(day: "Saturday", weather: "Sun", humidity: "30%", temperature: "24C"),
         DayWeather(day: "Sunday", weather: "Sun", humidity: "35%", temperature: "25C")]
    }
    
    override func viewDidLoad() {
        //tableView.tableHeaderView = nil
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: WeatherTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.classString)
        
        super.viewDidLoad()
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return weatherStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.classString, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let weatherInfo = weatherStruct[indexPath.row]
        weatherCell.dayLabel.text = weatherInfo.day
        weatherCell.humidityLabel.text = weatherInfo.humidity
        weatherCell.temperatureLabel.text = weatherInfo.temperature
        return weatherCell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56;
    }
}



