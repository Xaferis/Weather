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
    
    // MARK: - Variables
    
    var place: Place?
    
    var locationManager = LocationManager()
    
    var refreshControl = UIRefreshControl()

    
    var days = [DailyWeather]()
    
    @IBAction func search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() {
            present(navigationController, animated: true)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //String tam nezohrava ziadnu rolu, je tam len aby sa dal metoda zavolat
        //search(String())
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dateLabel.text = formatter.string(from: Date())
        
        locationLabel.text = place?.city
        LocationManager.shared.getLocation { [weak self] location, error in
            
            guard let self = self else { return }
            
            if let error = error {
                print("Tu je chyba")
            } else if let location = location {
                RequestManager.shared.getWeatherData(for: location.coordinates) { response in
                    switch response {
                    case .success(let weatherData):
                        self.setupView(with: weatherData.current)
                        self.days = weatherData.days
                        self.tableView.reloadData()
                    case .failure(let error):
                        print("Error")
                    }
                }
                
                self.locationLabel.text = location.city
            }
        }
        
        tableView.register(UINib(nibName: WeatherDayTableViewCell.classString, bundle: nil), forCellReuseIdentifier: WeatherDayTableViewCell.classString)
    }
    
    func setupView(with currentWeather: CurrentWeather) {
        self.temperatureLabel.text = currentWeather.temperatureWithCelsius
        self.feelsLikeLabel.text = currentWeather.feelsLikeWithCelsius
        weatherStatusLabel.text = currentWeather.weather.first?.description
    }
}

// MARK: - Table View Data Source

extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let weatherCell = tableView.dequeueReusableCell(
            withIdentifier: WeatherDayTableViewCell.classString,
            for: indexPath) as? WeatherDayTableViewCell
        else {
            return UITableViewCell()
        }
        
        weatherCell.setupCell(with: days[indexPath.row])
        return weatherCell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56;
    }
}
