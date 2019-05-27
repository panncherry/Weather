//
//  Location3DetailViewController.swift
//  Weather
//
//  Created by Pann Cherry on 5/27/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Location3DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var cloud: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTokyoWeatherData(url: API().WEATHER_URL, parameters: Locations().tokyoParams)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        backgroundView.customizeUIView(backgroundView)
    }
    
    // MARK: - Action
    @IBAction func didPressedBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchTokyoWeatherData(url: String, parameters: [String: String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                WeatherUpdateDetail().updateWeatherData(cityLabel: self.location!, cityTemperature: self.temperature!, cloud: self.cloud!, wind: self.wind!, weatherIcon: self.weatherIcon!, json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }

}
