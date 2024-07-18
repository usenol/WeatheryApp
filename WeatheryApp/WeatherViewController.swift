//
//  ViewController.swift
//  WeatheryApp
//
//  Created by Umut Şenol on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    let backgroundView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        layout()
    }

}

extension WeatherViewController {
    
    func style() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        if let image = UIImage(named: "day-background") {
            backgroundView.image = image
        } else {
            print("Resim yüklenemedi!")
        }
        backgroundView.contentMode = .scaleAspectFill
    }
    
    func layout() {
        view.addSubview(backgroundView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
