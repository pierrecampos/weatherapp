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
        indicator.color = .black
        indicator.backgroundColor = .red
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: - Components
    lazy var cityLabel = UILabelComponent(labelText: "Belo Horzionte, MG", fontSize: 30, fontWeight: .regular, fontColor: .primary)
    lazy var temperatureLabel = UILabelComponent(labelText: "21", fontSize: 128, fontWeight: .bold, fontColor: .secondary)
    lazy var temperatureSymbolLabel = UILabelComponent(labelText: "°C", fontSize: 32, fontWeight: .bold, fontColor: .primary)
    lazy var maxTemperature = MinMaxTemperatureFocusComponent(temperatureLabel: "Max: 22°", type: .max)
    lazy var minTemperature = MinMaxTemperatureFocusComponent(temperatureLabel: "Min: 18°", type: .min)
    lazy var dayLabel = UILabelComponent(labelText: "Segunda, 11", fontSize: 30, fontWeight: .regular, fontColor: .primary)
    lazy var dayDescription = UILabelComponent(labelText: "Céu Limpo", fontSize: 24, fontWeight: .light, fontColor: .primary)
    
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
    
    lazy var temperatureImage: UIImageView = {
        let uiImage = UIImageView()
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.image = UIImage(systemName: "sun.max.fill")?.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(.white)
        return uiImage
    }()
    
    lazy var probabilityPrecipitation = AditionalInfoComponent(iconName: .rain, iconSize: CGSize(width: 30, height: 30), descriptionText: "50%")
    lazy var windSpeed = AditionalInfoComponent(iconName: .wind, iconSize: CGSize(width: 30, height: 30), descriptionText: "16 km/h")
    lazy var humidity = AditionalInfoComponent(iconName: .humidity, iconSize: CGSize(width: 30, height: 30), descriptionText: "50%")
    
    //MARK: - Stacks Views
    lazy var temperatureMinMaxFocus = createStackView(items: [temperatureSymbolLabel, maxTemperature, minTemperature],
                                                      axis: .vertical,
                                                      alignment: .leading,
                                                      distribution: .fillEqually,
                                                      spacing: 10
    )
    
    lazy var temperatureFocus = createStackView(items: [temperatureLabel, temperatureMinMaxFocus], axis: .horizontal, alignment: .leading, distribution: .equalCentering, spacing: 0)
    
    lazy var aditionalInfoFocus = createStackView(items: [probabilityPrecipitation, windSpeed, humidity], axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 64)
    
    lazy var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        self.configureView()
        self.addSubViews()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        let fromColor = UIColor(red: 38/255, green: 43/255, blue: 43/255, alpha: 1).cgColor
        let toColor = UIColor(red: 15/255, green: 29/255, blue: 21/255, alpha: 1).cgColor
        
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func addSubViews() {
        self.addSubview(self.loadingIndicator)
        self.addSubview(cityLabel)
        self.addSubview(searchButton)
        self.addSubview(temperatureFocus)
        self.addSubview(dayLabel)
        self.addSubview(temperatureImage)
        self.addSubview(dayDescription)
        self.addSubview(aditionalInfoFocus)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
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
            
            self.temperatureImage.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 30),
            self.temperatureImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.dayDescription.topAnchor.constraint(equalTo: self.temperatureImage.bottomAnchor, constant: 30),
            self.dayDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.aditionalInfoFocus.topAnchor.constraint(equalTo: self.dayDescription.bottomAnchor, constant: 15),
            self.aditionalInfoFocus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
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
    
    public func setupInfo(with viewModel: HomeScreenViewModel, index: Int) {
        self.loadingIndicator.stopAnimating()
        self.cityLabel.text = "Belo Horizonte, MG" // TODO: Refactor to CLLocationManager
        self.temperatureLabel.text = viewModel.getTemperature(index)
        self.minTemperature.updateTemperatureText(viewModel.getMinTemperature(index))
        self.maxTemperature.updateTemperatureText(viewModel.getMaxTemperature(index))
        self.dayLabel.text = viewModel.getDayAndDate(index)
        self.temperatureImage.image = viewModel.getTemperatureImage(index)
        self.dayDescription.text = viewModel.getDayDescription(index)
        self.probabilityPrecipitation.updateData(descriptionText: viewModel.getProbabilityPrecipitation(index))
        self.windSpeed.updateData(descriptionText: viewModel.getWindSpeed(index))
        self.humidity.updateData(descriptionText: viewModel.getHumidity(index))
    }
}
