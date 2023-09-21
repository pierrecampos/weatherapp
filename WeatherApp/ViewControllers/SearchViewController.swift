//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 20/09/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    var screen: SearchScreenView?
    
    override func loadView() {
        self.screen = SearchScreenView()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupDelegates()
    }
    
    private func configure() {
        title = "Buscar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.primary]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primary]
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func setupDelegates() {
        screen?.setupDelegates(searchBarDelegate: self)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Texto: \(searchText)")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
}
