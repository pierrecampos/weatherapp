//
//  SearchScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 20/09/23.
//

import UIKit

class SearchScreenView: UIView {
    
    lazy var gradientLayer = CAGradientLayer()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        
        let fromColor = UIColor.backgroundOne.cgColor
        let toColor = UIColor.backgroundTwo.cgColor
        
        gradientLayer.colors = [fromColor, toColor]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        self.gradientLayer.frame = frame
    }
    
    private func addSubviews() {
        addSubview(tableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
    
    public func setupDelegates(dataSource: UITableViewDataSource, tableDelegate: UITableViewDelegate) {
        self.tableView.dataSource = dataSource
        self.tableView.delegate = tableDelegate        
    }
    
    
}
