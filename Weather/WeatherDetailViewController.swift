//
//  ViewController.swift
//  Weather
//
//  Created by Matúš Mištrik on 28/03/2022.
//

import UIKit

struct WeatherInfo {
    let day: String
    let weather: String
    let humidity: String
    let temperature: String
}


class WeatherDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherArray: [WeatherInfo] {
        [WeatherInfo(day: "Monday", weather: "Sun", humidity: "40%", temperature: "22°C"),
         WeatherInfo(day: "Tuesday", weather: "Sun", humidity: "30%", temperature: "23°C"),
         WeatherInfo(day: "Wednesday", weather: "Rain", humidity: "70%", temperature: "19°C"),
         WeatherInfo(day: "Thursday", weather: "Sun", humidity: "40%", temperature: "20°C"),
         WeatherInfo(day: "Friday", weather: "Rain", humidity: "65%", temperature: "18°C"),
         WeatherInfo(day: "Saturday", weather: "Sun", humidity: "30%", temperature: "24°C"),
         WeatherInfo(day: "Sunday", weather: "Sun", humidity: "35%", temperature: "25°C")]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: WeatherTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherTableViewCell.classString)
        
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.classString, for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        
        let model = WeatherTableViewCell.Model(weatherInfo: weatherArray[indexPath.row])
        weatherCell.setupView(weatherInfo: model)
        return weatherCell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56;
    }
}



