//
//  ViewController.swift
//  Weather
//
//  Created by Matúš Mištrik on 28/03/2022.
//

import UIKit
import CoreLocation

enum State {
    case loading
    case error (String)
    case success(WeatherResponse)
}

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherStatusLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Variables
    
    var place: Place?
    
    //var locationManager = LocationManager()
    var location: CurrentLocation?
    var days = [DailyWeather]()
    var refreshControl = UIRefreshControl()
    var state: State = .loading {
        didSet {
            reloadState()
        }
    }
    
    @IBAction func search(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SearchViewController", bundle: nil)
        if let navigationController = storyboard.instantiateInitialViewController() {
            present(navigationController, animated: true)
        }
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        LocationManager.shared.onAuthorizationChange { authorized in
            if authorized != nil {
                self.updateLocation()
            } else {
                
            }
        }
        
        if LocationManager.shared.denied {
            presentAlert()
        } else {
            updateLocation()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: = Actions
private extension WeatherDetailViewController {
    @IBAction func reload(_ sender: Any) {
        loadData()
    }
}

// MARK: - Setup
private extension WeatherDetailViewController {
    func setupTableView() {
        tableView.isHidden = true;
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        tableView.register(
            UINib(
                nibName: WeatherDayTableViewCell.classString,
                bundle: nil),
            forCellReuseIdentifier: WeatherDayTableViewCell.classString)
    }
    
    func setupView(with currentWeather: CurrentWeather) {
        locationLabel.text = location?.city
        dateLabel.text = DateFormatter.mediumDateFormattter.string(from: currentWeather.date)
        temperatureLabel.text = currentWeather.temperatureWithCelsius
        feelsLikeLabel.text = currentWeather.feelsLikeWithCelsius
        weatherStatusLabel.text = currentWeather.weather.first?.description
    }
    
    func presentAlert() {
        let alertController = UIAlertController(title: "Totot je title", message: "Toto je message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { action in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl) else {
                return
            }
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true)
    }
    
    func reloadState() {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
            tableView.isHidden = true
            emptyView.isHidden = true
            
        case .error(let message):
            refreshControl.endRefreshing()
            activityIndicator.stopAnimating()
            tableView.isHidden = true
            errorMessageLabel.text = message
            
        case .success(let weatherData):
            refreshControl.endRefreshing()
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            emptyView.isHidden = true
            setupView(with: weatherData.current)
            days = weatherData.days
            tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        }
    }
}

// MARK: - Request & Location

private extension WeatherDetailViewController {
   
    @objc func loadData() {
        guard let location = location else {
            return
        }
        
        state = .loading
        
        RequestManager.shared.getWeatherData(for: location.coordinates) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let weatherData):
                self.state = .success(weatherData)
            case .failure(let error):
                self.state = .error(error.localizedDescription)
            }
        }
    }
    
    func updateLocation() {
        LocationManager.shared.getLocation { [weak self] location, error in
            guard let self = self else { return }
            
            if let error = error {
                self.state = .error(error.localizedDescription)
            } else if let location = location {
                self.location = location
                self.loadData()
                }
            }
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
