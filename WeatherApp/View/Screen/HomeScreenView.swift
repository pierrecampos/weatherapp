//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeScreenView: UIView {
    
    lazy var temperatureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max.fill")
        return image
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 56)
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubViews()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        self.addSubview(self.temperatureImageView)
        self.addSubview(self.temperatureLabel)
        self.addSubview(self.temperatureSymbolLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.temperatureImageView.heightAnchor.constraint(equalToConstant: 170),
            self.temperatureImageView.widthAnchor.constraint(equalToConstant: 170),
            self.temperatureImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.temperatureImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.temperatureLabel.topAnchor.constraint(equalTo: self.temperatureImageView.bottomAnchor, constant: 20),
            self.temperatureLabel.centerXAnchor.constraint(equalTo: self.temperatureImageView.centerXAnchor),
            
            self.temperatureSymbolLabel.topAnchor.constraint(equalTo: self.temperatureLabel.topAnchor),
            self.temperatureSymbolLabel.leadingAnchor.constraint(equalTo: self.temperatureLabel.trailingAnchor, constant: 0),
        ])
    }
    
}
