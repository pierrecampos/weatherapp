//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 02/10/23.
//

import UIKit
import CoreLocation
import MapKit

protocol LocationManagerDelegate: AnyObject {
    func updateUserLocation()
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    private lazy var cllocationManager = CLLocationManager()
    private lazy var completer = MKLocalSearchCompleter()
    private lazy var searchResults: [(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)] = []
    private var searchCompletion: (([(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)]) -> Void)?
    var userLocationCoordinate: CLLocationCoordinate2D?
    
    
    private override init() {}
    
    //    MARK: - Public Methods
    public func requestUserLocationManager() {
        cllocationManager.delegate = self
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch CLLocationManager.authorizationStatus() {
                case .authorizedAlways, .authorizedWhenInUse:
                    self.cllocationManager.startUpdatingLocation()
                    break
                case .denied:
                    // TODO: dizer ao usuário que é necessário aceitar
                    break
                case .notDetermined:
                    self.cllocationManager.requestWhenInUseAuthorization()
                    break
                default:
                    break
                    // TODO:
                }
            }
        }
    }
    
    public func searchAddressesForText(_ text: String,
                                       completion: @escaping
                                       ([(title: String?,
                                          subtitle: String?,
                                          coordinate: CLLocationCoordinate2D?)
                                       ]) -> Void ) {
        completer.delegate = self
        completer.queryFragment = text
        
        if let userRegionCoordinate = self.userLocationCoordinate {
            let region = MKCoordinateRegion(center: userRegionCoordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            completer.region = region
        }
        
        searchCompletion = completion
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            cllocationManager.startUpdatingLocation()
            break;
        default:
            // TODO:
            break;
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.first?.coordinate {
            userLocationCoordinate = coordinate
            cllocationManager.stopUpdatingLocation()
            delegate?.updateUserLocation()
        }
    }
    
    func searchCoordinatesForAddress(_ address: (title: String, subtitle: String),
                                     completion: @escaping ((title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D?)?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        let entireAdddress = address.title + " " + address.subtitle
        searchRequest.naturalLanguageQuery = entireAdddress
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            if let response = response,
               let firstPlacemark = response.mapItems.first?.placemark {
                let coordinate = firstPlacemark.coordinate
                completion((title: address.title, subtitle: address.subtitle, coordinate: coordinate))
            } else {
                completion(nil)
            }
        }
    }
    
    func cancelSearchAddresses() {
        if completer.isSearching {
            completer.cancel()
        }
    }
}

extension LocationManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results.compactMap({ result in
            let street = result.title
            let subtitle = result.subtitle
            let searchRequest = MKLocalSearch.Request(completion: result)
            let coordinate = searchRequest.region.center
            
            return (title: street, subtitle: subtitle, coordinate: coordinate)
        })
        
        searchCompletion?(searchResults)
    }
    
    private func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        searchResults = []
        searchCompletion?(searchResults)
    }
}
