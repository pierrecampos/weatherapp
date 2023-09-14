//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeScreenView: UITableView {
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        self.configureView()
        self.registerItems()
        self.addSubViews()
        self.configConstraints()
    }
    
    private func configureView() {
        let gradientView = GradientView()
        gradientView.fromColor = UIColor(red: 38/255, green: 43/255, blue: 43/255, alpha: 1)
        gradientView.toColor = UIColor(red: 15/255, green: 29/255, blue: 21/255, alpha: 1)
        backgroundView = gradientView
        
        self.alwaysBounceVertical = false
    }
    
    private func registerItems() {
        self.register(HomeScreenViewHeader.self, forHeaderFooterViewReuseIdentifier: HomeScreenViewHeader.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    private func addSubViews() {
        self.addSubview(self.loadingIndicator)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    public func reloadTableView() {
        self.reloadData()
    }
    
    public func setupInfo(data: WeatherForecast) {
        self.loadingIndicator.stopAnimating()
    }
    
    
    
}

