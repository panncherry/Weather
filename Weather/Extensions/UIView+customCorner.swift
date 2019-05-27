//
//  UIView+customCorner.swift
//  Weather
//
//  Created by Pann Cherry on 5/26/19.
//  Copyright © 2019 Pann Cherry. All rights reserved.
//

import UIKit

extension UIView {
    
    func customizeUIView(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
    }
    
}
