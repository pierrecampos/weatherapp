//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 25/09/23.
//

import Foundation

protocol SearchScreenViewModelDelegate: AnyObject {
    func sucessFilterData()
}

class SearchScreenViewModel {
    
    public weak var delegate: SearchScreenViewModelDelegate?
    
    private var dataSource = ["Belo Horizonte", "Itaúna"]
    private var filteredData = [String]()
    
    var numberOfRows: Int {
        return filteredData.count
    }
    
    public func loadCurrentData(_ indexPath: IndexPath) -> String {
        return filteredData[indexPath.row]
    }
    
    public func filterData(with text: String) {
        // TODO: Call API
        filteredData = dataSource.filter({$0.localizedCaseInsensitiveContains(text)})
        delegate?.sucessFilterData()
    }
}
