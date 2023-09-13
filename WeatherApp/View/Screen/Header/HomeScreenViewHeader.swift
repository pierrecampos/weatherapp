//
//  HomeScreenViewHeader.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 12/09/23.
//

import UIKit

class HomeScreenViewHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"

    lazy var cityLabel = UILabelComponent(labelText: "Belo Horzionte, MG", fontSize: 30, fontWeight: .regular, fontColor: .primary)
    lazy var temperatureLabel = UILabelComponent(labelText: "21", fontSize: 128, fontWeight: .bold, fontColor: .secondary)
    lazy var temperatureSymbolLabel = UILabelComponent(labelText: "°C", fontSize: 32, fontWeight: .bold, fontColor: .primary)
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let searchImage = UIImage(systemName: "magnifyingglass")
        button.setImage(searchImage, for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 26, left: 26, bottom: 26, right: 26)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubviews()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)  has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(cityLabel)
        self.addSubview(searchButton)
        self.addSubview(temperatureLabel)
        self.addSubview(temperatureSymbolLabel)
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.cityLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.cityLabel.trailingAnchor.constraint(equalTo: self.searchButton.leadingAnchor, constant: -22),
            self.cityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            
            self.searchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            self.searchButton.centerYAnchor.constraint(equalTo: self.cityLabel.centerYAnchor),
            self.searchButton.heightAnchor.constraint(equalToConstant: 26),
            
            self.temperatureLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 30),
            self.temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            
            
            self.temperatureSymbolLabel.topAnchor.constraint(equalTo: self.temperatureLabel.topAnchor),
            self.temperatureSymbolLabel.leadingAnchor.constraint(equalTo: self.temperatureLabel.trailingAnchor),
        ])
    }
    
    public func setupHeader(with forecast: WeatherForecast) {
        self.cityLabel.text = "Belo Horizonte, MG" // TODO: Refactor to CLLocationManager
    }
    
}
