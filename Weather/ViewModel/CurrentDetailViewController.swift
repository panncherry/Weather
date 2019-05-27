//
//  CurrentDetailViewController.swift
//  Weather
//
//  Created by Pann Cherry on 5/27/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire


class CurrentDetailViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        backgroundView.customizeUIView(backgroundView)
    }
    
    
    // MARK: Action
    @IBAction func didTappedBackButton(_ sender: Any) {
        print("Back button pressed.")
        self.dismiss(animated: true)
    }
    
    
    func fetchCurrentWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                WeatherUpdateDetail().updateWeatherData(cityLabel: self.locationLabel, cityTemperature: self.temperatureLabel, cloud: self.cloudLabel, wind: self.windLabel, weatherIcon: self.weatherIcon, json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    // MARK: - Did update current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : API().APP_ID]
            fetchCurrentWeatherData(url: API().WEATHER_URL, parameters: params)
        }
    }
   
}
