//
//  ViewController.swift
//  WeatheryApp
//
//  Created by Umut Şenol on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    let backgroundView = UIImageView()
    let locationButton = UIButton()
    let searchButton = UIButton()
    let searchTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

}

extension WeatherViewController {
    
    func style() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        ///Background View Style
        if let image = UIImage(named: "day-background") {
            backgroundView.image = image
        } else {
            print("Image failed to load!")
        }
        backgroundView.contentMode = .scaleAspectFill
        
        ///Location Button Style
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: "location.north.circle.fill") {
            locationButton.setBackgroundImage(image, for: .normal)
            locationButton.tintColor = .label
        } else {
            print("Image failed to load!")
        }
        
        ///Search Button Style
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(systemName: "magnifyingglass") {
            searchButton.setBackgroundImage(image, for: .normal)
            searchButton.tintColor = .label
        } else {
            print("Image failed to load!")
        }
        
        ///Search Text Field Style
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.font = UIFont.preferredFont(forTextStyle: .title1)
        searchTextField.placeholder = "Search"
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .systemFill
        
    }
    
    func layout() {
        view.addSubview(backgroundView)
        view.addSubview(locationButton)
        view.addSubview(searchButton)
        view.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            locationButton.widthAnchor.constraint(equalToConstant: 40),
            locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            //view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchButton.trailingAnchor, multiplier: 1),
            searchButton.widthAnchor.constraint(equalToConstant: 40),
            searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: locationButton.trailingAnchor, multiplier: 1),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -8),
            //searchButton.leadingAnchor.constraint(equalToSystemSpacingAfter: searchTextField.trailingAnchor, multiplier: 1),
            searchTextField.widthAnchor.constraint(equalToConstant: 40),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
