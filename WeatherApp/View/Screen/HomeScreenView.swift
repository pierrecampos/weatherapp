//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeScreenView: UIView {
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.text = "Belo Horizonte"
        return label
    }()
    
    lazy var temperatureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max.fill")
        return image
    }()
    
    lazy var temperatureDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Céu Limpo"
        return label
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50)
        label.text = "21"
        return label
        
    }()
    
    lazy var temperatureSymbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.text = "°C"
        return label
    }()
    
    var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGradientView()
        self.addSubViews()
        self.configConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    func setupGradientView(){
        self.backgroundColor = .white

        let fistColor = CGColor(red: 38/255, green: 43/255, blue: 43/255, alpha: 1)
        let secondColor = CGColor(red: 15/255, green: 29/255, blue: 21/255, alpha: 1)
        gradientLayer.colors = [fistColor, secondColor]
        gradientLayer.locations = [0.5, 1.0]
        
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func addSubViews() {
        self.addSubview(self.cityLabel)
        self.addSubview(self.temperatureImageView)
        self.addSubview(self.temperatureDescription)
        self.addSubview(self.temperatureLabel)
        self.addSubview(self.temperatureSymbolLabel)
        self.addSubview(self.loadingIndicator)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.cityLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.cityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.cityLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.temperatureImageView.heightAnchor.constraint(equalToConstant: 100),
            self.temperatureImageView.widthAnchor.constraint(equalToConstant: 100),
            self.temperatureImageView.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 20),
            self.temperatureImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.temperatureDescription.topAnchor.constraint(equalTo: self.temperatureImageView.bottomAnchor, constant: 6),
            self.temperatureDescription.centerXAnchor.constraint(equalTo: self.temperatureImageView.centerXAnchor),
            
            self.temperatureLabel.topAnchor.constraint(equalTo: self.temperatureDescription.bottomAnchor, constant: 20),
            self.temperatureLabel.centerXAnchor.constraint(equalTo: self.temperatureDescription.centerXAnchor),
            
            self.temperatureSymbolLabel.topAnchor.constraint(equalTo: self.temperatureLabel.topAnchor),
            self.temperatureSymbolLabel.leadingAnchor.constraint(equalTo: self.temperatureLabel.trailingAnchor, constant: 0),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    public func setupInfo(data: WeatherForecastModel) {
        let weatherForecast = data.list[0]
        self.loadingIndicator.stopAnimating()
        self.temperatureLabel.text = String(format:"%.0f", round(weatherForecast.main.temp))
        
    }
    
}

