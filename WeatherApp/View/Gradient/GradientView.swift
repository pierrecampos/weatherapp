
//  GradientView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 12/09/23.
//

import UIKit

class GradientView: UIView {
    
    /* Overriding default layer class to use CAGradientLayer */
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    /* Handy accessor to avoid unnecessary casting */
    private var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    /* Public properties to manipulate colors */
    public var fromColor: UIColor = UIColor.white {
        didSet {
            var currentColors = gradientLayer.colors
            currentColors![0] = fromColor.cgColor
            gradientLayer.colors = currentColors
        }
    }
    
    public var toColor: UIColor = UIColor.black {
        didSet {
            var currentColors = gradientLayer.colors
            currentColors![1] = toColor.cgColor
            gradientLayer.colors = currentColors
        }
    }
    
    /* Initializers overriding to have appropriately configured layer after creation */
    override init(frame: CGRect) {
        super.init(frame: frame)
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
    }
    
}
