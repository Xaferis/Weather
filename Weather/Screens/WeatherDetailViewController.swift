//
//  ViewController.swift
//  Weather
//
//  Created by Matúš Mištrik on 28/03/2022.
//

import UIKit
import CoreLocation

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var locationManager = LocationManager()
    
    // MARK: - Variables
    
    var refreshControl = UIRefreshControl()

    
    var weatherArray: [ForecastDay] {
        [ForecastDay(title: "Saturday", temperature: 22, perception: 40, state:.cloudy),
         ForecastDay(title: "Sunday", temperature: 23, perception: 30, state:.cloudy),
         ForecastDay(title: "Monday", temperature: 19, perception: 70, state:.rainy),
         ForecastDay(title: "Tuesday", temperature: 24, perception: 20, state:.rainy),
         ForecastDay(title: "Wednesday", temperature: 25, perception: 10, state:.sunny),
         ForecastDay(title: "Thursday", temperature: 26, perception: 10, state:.sunny)]
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: Date())
        
        
        LocationManager.shared.getLocation { [weak self] location, error in
            
            if let error = error {
                print("Tu je chyba")
            } else if let location = location {
                self?.locationLabel.text = location.city
            }
        }
        
        tableView.register(UINib(nibName: WeatherDayTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherDayTableViewCell.classString)
    }
}

// MARK - Table View Data Source

extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return weatherArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.classString, for: indexPath) as? WeatherDayTableViewCell else {
            return UITableViewCell()
        }
        
        weatherCell.setupCell(with: weatherArray[indexPath.row])
        return weatherCell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56;
    }
}
