//
//  ViewController.swift
//  Weather
//
//  Created by Pann Cherry on 5/26/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import AlamofireImage
import SwiftyJSON


class ForecastViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    
    // MARK: - IBOutlets
    @IBOutlet weak var currentLocationView: UIView!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentLocationTemperature: UILabel!
    @IBOutlet weak var currentCity: UILabel!
    
    
    @IBOutlet weak var londonView: UIView!
    @IBOutlet weak var londonWeatherIcon: UIImageView!
    @IBOutlet weak var londonTemperature: UILabel!
    @IBOutlet weak var london: UILabel!
    
    
    @IBOutlet weak var tokyoView: UIView!
    @IBOutlet weak var tokyoWeatherIcon: UIImageView!
    @IBOutlet weak var tokyoTemperature: UILabel!
    @IBOutlet weak var tokyo: UILabel!
    
    
    // MARK: - Life Cycels
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        fetchToKyoWeatherData(url: API().WEATHER_URL, parameters: Locations().tokyoParams)
        fetchLondonWeatherData(url: API().WEATHER_URL, parameters: Locations().londonParams)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        currentLocationView.customizeUIView(currentLocationView)
        londonView.customizeUIView(londonView)
        tokyoView.customizeUIView(tokyoView)
    }
    
    // MARK: - Actions
    func fetchToKyoWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                
                WeatherUpdate().updateWeatherData(cityLabel: self.tokyo!, cityTemperature: self.tokyoTemperature!, weatherIcon: self.tokyoWeatherIcon!, json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }

    
    func fetchLondonWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                WeatherUpdate().updateWeatherData(cityLabel: self.london!, cityTemperature: self.londonTemperature!, weatherIcon: self.londonWeatherIcon!, json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    func fetchCurrentWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                WeatherUpdate().updateWeatherData(cityLabel: self.currentCity!, cityTemperature: self.currentLocationTemperature!, weatherIcon: self.currentWeatherIcon!, json: weatherJSON)
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
