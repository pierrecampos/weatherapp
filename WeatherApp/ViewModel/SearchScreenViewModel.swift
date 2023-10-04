//
//  SearchScreenViewModel.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 25/09/23.
//

import Foundation
import CoreLocation

protocol SearchScreenViewModelDelegate: AnyObject {
    func sucessFilterData()
}

class SearchScreenViewModel {
    
    public weak var delegate: SearchScreenViewModelDelegate?
    private var filteredData: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)] = []
    
    var numberOfRows: Int {
        return filteredData.count
    }
    
    public func loadCurrentData(_ indexPath: IndexPath) -> (title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?) {
        return filteredData[indexPath.row]
    }
    
    public func filterData(with text: String) {        
        LocationManager.shared.cancelSearchAddresses()
        LocationManager.shared.searchAddressesForText(text) { [weak self]( result: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)]) in
            self?.filteredData = result
            self?.delegate?.sucessFilterData()
        }
    }
}
