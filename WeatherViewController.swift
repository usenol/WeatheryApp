//
//  ViewController.swift
//  WeatheryApp
//
//  Created by Umut Şenol on 18.07.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    var weatherService = WeatherService()
    
    let backgroundView = UIImageView()
    let rootStackView = UIStackView()
    
    //Search
    let searchStackView = UIStackView()
    let locationButton = UIButton()
    let searchButton = UIButton()
    let searchTextField = UITextField()
    
    //Weather
    let conditionImageView = UIImageView()
    let temperatureLabel = UILabel()
    let cityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
}

extension WeatherViewController {
    
    func setup() {
        searchTextField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherService.delegate = self
    }
    
    func style() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        ///Background View Style
        if let image = UIImage(named: "day-background") {
            backgroundView.image = image
        } else {
            print("Image failed to load!")
        }
        backgroundView.contentMode = .scaleAspectFill
        
        ///Root Stack View
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.axis = .vertical
        rootStackView.alignment = .trailing
        rootStackView.spacing = 10
        
        ///Search Stack View
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        searchStackView.spacing = 8
        
        ///Location Button Style
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: "location.north.circle.fill") {
            locationButton.setBackgroundImage(image, for: .normal)
            locationButton.tintColor = .label
        } else {
            print("Image failed to load!")
        }
        locationButton.addTarget(self, action: #selector(locationPressed(_:)), for: .primaryActionTriggered)
        
        ///Search Button Style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: "magnifyingglass") {
            searchButton.setBackgroundImage(image, for: .normal)
            searchButton.tintColor = .label
        } else {
            print("Image failed to load!")
        }
        searchButton.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        
        ///Search Text Field Style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
        //Weather
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.image = UIImage(systemName: "sun.max")
        conditionImageView.tintColor = .label
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 80)
        temperatureLabel.attributedText = makeTemperatureText(with: "21")
         
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        cityLabel.text = "Ankara"
    }
    
    func makeTemperatureText(with temperature: String) -> NSAttributedString {
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 100)
        
        var plainTextAttirbutes = [NSAttributedString.Key: AnyObject]()
        plainTextAttirbutes[.font] = UIFont.systemFont(ofSize: 80)
        
        let text = NSMutableAttributedString(string: temperature, attributes: boldTextAttributes)
        text.append(NSAttributedString(string: "°C", attributes: plainTextAttirbutes))
        
        return text
    }
    
    func layout() {
        view.addSubview(backgroundView)
        view.addSubview(rootStackView)
        
        rootStackView.addArrangedSubview(searchStackView)
        rootStackView.addArrangedSubview(conditionImageView)
        rootStackView.addArrangedSubview(temperatureLabel)
        rootStackView.addArrangedSubview(cityLabel)
        
        searchStackView.addArrangedSubview(locationButton)
        searchStackView.addArrangedSubview(searchTextField)
        searchStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: rootStackView.trailingAnchor, multiplier: 1),
            
            searchStackView.widthAnchor.constraint(equalTo: rootStackView.widthAnchor),
            
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            conditionImageView.heightAnchor.constraint(equalToConstant: 120),
            conditionImageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherService.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    
    @objc func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
           // weatherService.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}

// MARK: - WeatherServiceDelegate

extension WeatherViewController: WeatherServiceDelegate {
    
    func didFetchWeather(_ weatherService: WeatherService, weather: Weather) {
//        Update UI
        temperatureLabel.attributedText = makeTemperatureText(with: weather.temperatureString)
        cityLabel.text = weather.cityName
    }
    
}
