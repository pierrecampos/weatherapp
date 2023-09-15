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
        
        let indexPath = IndexPath(item: 0, section: 0)
        self.screen?.collectionView.selectItem(at: indexPath , animated: false, scrollPosition: .top)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell()}
        cell.setup(weatherForecast: viewModel.loadCurrentWeatherForecast(indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.screen?.setupInfo(with: viewModel, index: indexPath.item)       
        
    }
    
}

