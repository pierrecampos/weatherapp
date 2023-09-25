//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 20/09/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    var viewModel =  SearchScreenViewModel()
    var screen: SearchScreenView?
    var searchController = UISearchController(searchResultsController: nil)
    
    
    override func loadView() {
        self.screen = SearchScreenView()
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureSearchController()
        setupDelegates()
        definesPresentationContext = true
    }
    
    private func configure() {
        title = "Buscar Localização"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.primary]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primary]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configureSearchController() {
        searchController.searchBar.backgroundImage = UIImage()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.leftView?.tintColor = .primary
        searchController.searchBar.searchTextField.rightView?.tintColor = .primary
        searchController.searchBar.tintColor = .primary
        
        navigationItem.searchController = searchController
    }
    
    private func setupDelegates() {
        self.screen?.setupDelegates(dataSource: self, tableDelegate: self)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        self.viewModel.delegate = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            viewModel.filterData(with: text)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.textColor = .secondary
        cell.textLabel?.text = viewModel.loadCurrentData(indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Refactor
        searchController.dismiss(animated: false)
        self.dismiss(animated: true)
    }
}

extension SearchViewController: SearchScreenViewModelDelegate {
    func sucessFilterData() {
        self.screen?.tableView.reloadData()
    }
}
