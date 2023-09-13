//
//  HomeScreenViewHeader.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 12/09/23.
//

import UIKit

class HomeScreenViewHeader: UITableViewHeaderFooterView {
    static let identifier = "TableHeader"
    
    //MARK: - Components
    lazy var cityLabel = UILabelComponent(labelText: "Belo Horzionte, MG", fontSize: 30, fontWeight: .regular, fontColor: .primary)
    lazy var temperatureLabel = UILabelComponent(labelText: "21", fontSize: 128, fontWeight: .bold, fontColor: .secondary)
    lazy var temperatureSymbolLabel = UILabelComponent(labelText: "°C", fontSize: 32, fontWeight: .bold, fontColor: .primary)
    lazy var maxTemperature = MinMaxTemperatureFocusComponent(temperatureLabel: "Max: 22°", type: .max)
    lazy var minTemperature = MinMaxTemperatureFocusComponent(temperatureLabel: "Min: 18°", type: .min)
    lazy var dayLabel = UILabelComponent(labelText: "Segunda, 11", fontSize: 30, fontWeight: .regular, fontColor: .primary)
    
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
    
    //MARK: - Stacks Views
    lazy var temperatureMinMaxFocus = createStackView(items: [temperatureSymbolLabel, maxTemperature, minTemperature],
                                                      axis: .vertical, alignment: .leading, distribution: .fillEqually, spacing: 15)
    lazy var temperatureFocus = createStackView(items: [temperatureLabel, temperatureMinMaxFocus], axis: .horizontal, alignment: .leading, distribution: .equalCentering, spacing: 0)
    
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
        self.addSubview(temperatureFocus)
        self.addSubview(dayLabel)
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.cityLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.cityLabel.trailingAnchor.constraint(equalTo: self.searchButton.leadingAnchor, constant: -22),
            self.cityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 22),
            
            self.searchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -22),
            self.searchButton.centerYAnchor.constraint(equalTo: self.cityLabel.centerYAnchor),
            self.searchButton.heightAnchor.constraint(equalToConstant: 26),
            
            self.temperatureFocus.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 30),
            self.temperatureFocus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.temperatureFocus.heightAnchor.constraint(equalToConstant: 100),
            
            self.dayLabel.topAnchor.constraint(equalTo: self.temperatureFocus.bottomAnchor, constant: 30),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
        ])
    }
    
    private func createStackView(items: [UIView], axis: NSLayoutConstraint.Axis, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        stack.spacing = spacing
        
        items.forEach { view in
            stack.addArrangedSubview(view)
        }
        
        return stack
    }
    
    public func setupHeader(with forecast: WeatherForecast) {
        let viewModel = HeaderViewModel(forecast)
        
        self.cityLabel.text = "Belo Horizonte, MG" // TODO: Refactor to CLLocationManager
        self.temperatureLabel.text = viewModel.getTemperature
        self.minTemperature.updateTemperatureText(viewModel.getMinTemperature)
        self.maxTemperature.updateTemperatureText(viewModel.getMaxTemperature)
        self.dayLabel.text = viewModel.getDayAndDate
    }
    
}
