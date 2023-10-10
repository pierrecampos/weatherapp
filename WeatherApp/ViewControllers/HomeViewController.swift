//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 08/09/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    private var viewModel: HomeScreenViewModel!
    private var screen: HomeScreenView?
    private var dataSource: ForecastCollectionViewDataSource<CustomCollectionViewCell, WeatherForecast>!
    
    override func loadView() {
        self.screen = HomeScreenView()
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.secondary, .font: UIFont.systemFont(ofSize: 22, weight: .bold)]
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        searchButton.tintColor = .secondary
        navigationItem.rightBarButtonItem = searchButton
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.insertGradientLayer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel = HomeScreenViewModel()
        setupDelegates()
        requestUserLocation()
    }
    
    private func setupDelegates() {
        viewModel.delegate = self
        LocationManager.shared.delegate = self
    }
    
    private func requestUserLocation() {
        LocationManager.shared.requestUserLocationManager()
    }
    
    @objc func searchTapped() {
        let searchController = SearchViewController()
        searchController.delegate = self
        let nav = UINavigationController(rootViewController: searchController)
        present(nav, animated: true)
    }
}

extension HomeViewController: HomeScreenViewModelDelegate {
    func successFetchData() {
        self.dataSource = ForecastCollectionViewDataSource(cellIdentifier: CustomCollectionViewCell.identifier, items: viewModel.forecastData.singleDays, configureCell: { cell, data in
            cell.setup(weatherForecast: data)
        })
        
        self.screen?.setupDelegates(collectionViewDelegate: self, collectionViewDataSource: dataSource)
        let indexPath = IndexPath(item: 0, section: 0)
        self.screen?.collectionView.selectItem(at: indexPath , animated: false, scrollPosition: .top)
        self.screen?.collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        self.screen?.setupInfo(with: viewModel, index: 0)
        self.screen?.showContainer(isHidden: false)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.screen?.setupInfo(with: viewModel, index: indexPath.item)
    }
}

extension HomeViewController: SearchViewControllerDelegate {
    func userSelectedCity(nameOfTheCity: String) {
        title = nameOfTheCity
        self.screen?.showContainer(isHidden: true)
        self.screen?.loadingIndicator.startAnimating()
    }
}

extension HomeViewController: LocationManagerDelegate {
    func updateUserLocation() {
        let coordinate =  LocationManager.shared.userLocationCoordinate
        self.viewModel.fetchWeatherForecast(latitude: coordinate!.latitude, longitude: coordinate!.longitude)
        //            self.viewModel.fetchWeatherForecastJSON()
        
    }
    
    func updateUserCityName(_ cityName: String) {
        title = cityName
    }
}

