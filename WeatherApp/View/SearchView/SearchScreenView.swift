//
//  SearchScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 20/09/23.
//

import UIKit

class SearchScreenView: UIView {
    
    lazy var gradientLayer = CAGradientLayer()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .black
        searchBar.searchTextField.leftView?.tintColor = .primary
        searchBar.searchTextField.rightView?.tintColor = .primary
        searchBar.tintColor = .primary
        return searchBar
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
        addSubview(searchBar)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    public func setupDelegates(searchBarDelegate: UISearchBarDelegate) {
        searchBar.delegate = searchBarDelegate
    }
    
    
}
