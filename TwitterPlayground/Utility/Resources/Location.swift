//
//  Location.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    enum Error: Swift.Error {
        case locationNotAuthorized
        case locationUnavailable
    }
    
    static var sharedInstance = Location()
    private var locationManager = CLLocationManager()

    private var authorizationChangeCallback: ((Result<CLLocation, Error>) -> Void)?

    func getCurrentLocation(completion: @escaping (Result<CLLocation, Error>) -> Void) {
        self.authorizationChangeCallback = completion
        checkCurrentStatus()
    }

    func checkCurrentStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            if let callback = self.authorizationChangeCallback {
                guard let location = locationManager.location else {
                    callback(.failure(Error.locationUnavailable))
                    return
                }

                callback(.success(location))
            }

        case .notDetermined:
            requestLocationPermission()

        case .denied:
            authorizationChangeCallback?(.failure(.locationNotAuthorized))

        default:
            authorizationChangeCallback?(.failure(.locationUnavailable))
        }
    }

    func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkCurrentStatus()
    }
}
