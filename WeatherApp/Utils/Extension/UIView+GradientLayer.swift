//
//  UIView+GradientLayer.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 10/10/23.
//

import UIKit

extension UIView {
    func insertGradientLayer() {
        let gradientLayer = CAGradientLayer()
        let fromColor = UIColor.backgroundOne.cgColor
        let toColor = UIColor.backgroundTwo.cgColor
        
        gradientLayer.frame = bounds
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)        
    }
}
