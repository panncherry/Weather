//
//  updateForecast.swift
//  Weather
//
//  Created by Pann Cherry on 5/26/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class WeatherUpdate {
    func updateWeatherData(cityLabel: UILabel, cityTemperature: UILabel, weatherIcon: UIImageView, json : JSON) {
        var temperature = cityTemperature
        var name = cityLabel
        var icon = weatherIcon
        
        let tempResult = json["main"]["temp"].doubleValue
        temperature.text = String(Int(tempResult - 273.15)) + "°"
        name.text = json["name"].stringValue
        //tokyo.condition  = json["weather"][0]["id"].intValuet
        let baseURL = "http://openweathermap.org/img/w/"
        let weatherIcon = json["weather"][0]["icon"].stringValue
        let urlEnding = ".png"
        let url = URL(string: baseURL + weatherIcon + urlEnding)!
        icon.af_setImage(withURL: url)
    }
}

