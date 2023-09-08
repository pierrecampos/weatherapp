//
//  HomeScreenView.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeScreenView: UIView {
    


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubViews()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
       
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
         
        ])
    }
    
}
