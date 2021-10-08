//
//  LocationService.swift
//  Weather
//
//  Created by Александр Меренков on 10/7/21.
//

import CoreLocation

protocol LocationServiceDelegate: class {
    func promptAuthorizationAction()
    func didAuthorize()
}

class LocationService: NSObject {
    weak var delegate: LocationServiceDelegate?
    
    private var locationManager = CLLocationManager()
    
    public var exposedLocation: CLLocation? {
        return self.locationManager.location
    }
    
    var enabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    override init() {
        super.init()
//        self.locationManager = locationManager
        self.locationManager.delegate = self
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("notDetermined")
        case .denied:
            delegate?.promptAuthorizationAction()
        case .restricted:
            delegate?.promptAuthorizationAction()
        case .authorizedWhenInUse:
            delegate?.didAuthorize()
        case .authorizedAlways:
            delegate?.didAuthorize()
        default:
            delegate?.promptAuthorizationAction()
        }
    }
    
    func getPlace(for location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in

            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            guard let placemark = placemarks?[0] else {
                print("Placemark is nil")
                return
            }
            completion(placemark)
        }
    }    
}

