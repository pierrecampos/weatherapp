//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeScreenViewModel?
    var screen: HomeScreenView?
    
    override func loadView() {
        self.screen = HomeScreenView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = "Itauna, MG"
        self.configNavigationBarButtonItems()
        self.setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel?.fetchWeatherForecast()
    }
    
    private func configNavigationBarButtonItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: nil)
    }
    
    private func setupData() {
        self.viewModel = HomeScreenViewModel()
    }
    
    
}
