//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Pierre Campos Dias on 02/10/23.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func updateUserLocation()
}

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    weak var delegate: LocationManagerDelegate?
    
    private lazy var cllocationManager = CLLocationManager()
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
}
