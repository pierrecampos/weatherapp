//
//  CustomCollectionViewCell.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 15/09/23.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    //MARK: - UI
    lazy var dayOfWeekLabel = UILabelComponent(labelText: "Seg", fontSize: 16, fontWeight: .regular, fontColor: .secondary)
    lazy var maxTemperatureLabel = UILabelComponent(labelText: "24°", fontSize: 14, fontWeight: .regular, fontColor: .secondary)
    lazy var minTemperatureLabel = UILabelComponent(labelText: "19°", fontSize: 14, fontWeight: .regular, fontColor: .primary)
    
    lazy var stackTemperature =  Utils.createStackView(items: [maxTemperatureLabel, minTemperatureLabel],
                                                       axis: .horizontal,
                                                       alignment: .center,
                                                       distribution: .equalSpacing,
                                                       spacing: 10
    )
    
    lazy var temperatureImage: UIImageView = {
        let temperatureImage = UIImageView()
        temperatureImage.translatesAutoresizingMaskIntoConstraints = false
        temperatureImage.image = UIImage(systemName: "sun.max")?.scalePreservingAspectRatio(targetSize: CGSize(width: 40, height: 40)).withTintColor(.white)
        return temperatureImage
    }()
    
    lazy var stackContainer = Utils.createStackView(items: [dayOfWeekLabel, temperatureImage, stackTemperature],
                                                    axis: .vertical,
                                                    alignment: .center,
                                                    distribution: .equalSpacing,
                                                    spacing: 6
    )
    
    //MARK: - Properties
    public static var identifier = "CustomCollectionViewCell"
    private var viewModel: CustomCollectionViewCellViewModel! {
        didSet {
            dayOfWeekLabel.text = self.viewModel?.dayOfWeek
            temperatureImage.image = self.viewModel?.temperatureImage
            minTemperatureLabel.text = self.viewModel?.minTemperature
            maxTemperatureLabel.text = self.viewModel?.maxTemperature
        }
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? UIColor.primary.cgColor : UIColor.backgroundOne.cgColor
        }
    }
    
    //MARK: - Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    private func configure() {
        layer.cornerRadius = 8
        layer.borderColor = UIColor.backgroundOne.cgColor
        layer.borderWidth = 1
        backgroundColor = UIColor.backgroundTwo
    }
    
    private func addSubViews() {
        self.addSubview(dayOfWeekLabel)
        self.addSubview(temperatureImage)
        self.addSubview(stackTemperature)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            self.dayOfWeekLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.dayOfWeekLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.temperatureImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.temperatureImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            self.stackTemperature.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.stackTemperature.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    public func setup(weatherForecast viewModel: WeatherForecast) {
        self.viewModel = CustomCollectionViewCellViewModel(weatherForecast: viewModel)
    }
}
