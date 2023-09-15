//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeScreenViewModel()
    var screen: HomeScreenView?
    
    override func loadView() {
        self.screen = HomeScreenView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.setupDelegates()
    }
        
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchWeatherForecast()
    }
}

extension HomeViewController: HomeScreenViewModelDelegate {
    func successFetchData() {
        self.screen?.setupDelegates(delegate: self, dataSource: self)
        self.screen?.setupInfo(with: viewModel, index: 0)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}

