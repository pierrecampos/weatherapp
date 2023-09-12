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
        self.setupDelegates()
    }
    
    private func setupDelegates() {
        viewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.viewModel.fetchWeatherForecast()
    }

    
}

// MARK: - Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Refactor
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
    }

}

extension HomeViewController: HomeScreenViewModelDelegate {
    func successFetchData() {
        self.screen?.setupTableViewProtocols(delegate: self, dataSource: self)
        self.screen?.setupInfo(data: self.viewModel.dataSource.list[0])
        self.screen?.reloadTableView()
    }
}

