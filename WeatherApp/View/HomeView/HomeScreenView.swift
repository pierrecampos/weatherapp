//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

protocol HomeScreenViewDelegate: AnyObject {
    func searchTapped()
}

class HomeScreenView: UIView {
    
    public weak var delegate: HomeScreenViewDelegate?
    
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
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var temperatureImage: UIImageView = {
        let uiImage = UIImageView()
        uiImage.contentMode = .scaleAspectFit
        uiImage.translatesAutoresizingMaskIntoConstraints = false
        uiImage.image = UIImage(systemName: "sun.max.fill")?.scalePreservingAspectRatio(targetSize: CGSize(width: 120, height: 120)).withTintColor(.white)
        return uiImage
    }()
    
    lazy var probabilityPrecipitation = AditionalInfoComponent(iconName: .rain, iconSize: CGSize(width: 30, height: 30), descriptionText: "50%")
    lazy var windSpeed = AditionalInfoComponent(iconName: .wind, iconSize: CGSize(width: 30, height: 30), descriptionText: "16 km/h")
    lazy var humidity = AditionalInfoComponent(iconName: .humidity, iconSize: CGSize(width: 30, height: 30), descriptionText: "50%")
    
    //MARK: - Stacks Views
    lazy var temperatureMinMaxFocus = Utils.createStackView(items: [temperatureSymbolLabel, maxTemperature, minTemperature],
                                                      axis: .vertical,
                                                      alignment: .leading,
                                                      distribution: .fillEqually,
                                                      spacing: 10
    )
    
    lazy var temperatureFocus =  Utils.createStackView(items: [temperatureLabel, temperatureMinMaxFocus], axis: .horizontal, alignment: .leading, distribution: .equalCentering, spacing: 0)
    
    lazy var aditionalInfoFocus =  Utils.createStackView(items: [probabilityPrecipitation, windSpeed, humidity], axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 64)
    
    // MARK: - CollectionView
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 1
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        self.configureView()
        self.addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        let fromColor = UIColor.backgroundOne.cgColor
        let toColor = UIColor.backgroundTwo.cgColor
        
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        self.configConstraints()
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
        self.addSubview(collectionView)
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
            
            self.temperatureLabel.widthAnchor.constraint(equalToConstant: 200),
            
            self.temperatureFocus.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 30),
            self.temperatureFocus.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.temperatureFocus.heightAnchor.constraint(equalToConstant: 100),
            
            self.dayLabel.topAnchor.constraint(equalTo: self.temperatureFocus.bottomAnchor, constant: 30),
            self.dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.temperatureImage.topAnchor.constraint(equalTo: self.dayLabel.bottomAnchor, constant: 30),
            self.temperatureImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.temperatureImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.temperatureImage.heightAnchor.constraint(equalToConstant: 120),
            
            self.dayDescription.bottomAnchor.constraint(equalTo: self.aditionalInfoFocus.topAnchor, constant: -30),
            self.dayDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.aditionalInfoFocus.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -15),
            self.aditionalInfoFocus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            self.aditionalInfoFocus.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: frame.height * 0.2),
        
            
            
        ])
        // Configure Flow Layout
        self.flowLayout.itemSize = CGSize(width: frame.height * 0.15 - 1, height: frame.height * 0.15 - 1)
    }
    
    @objc private func searchTapped() {
        self.delegate?.searchTapped()
    }
    
    
    public func setupDelegates(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
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

