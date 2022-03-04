//
//  ViewController.swift
//  BackgroundUpdate
//
//  Created by 성준 on 2022/03/04.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    var backgroundCnt: Int = 0
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true //중료
    }
}


// MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        default:
            break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let state = UIApplication.shared.applicationState
        switch state {
        case .background:
            backgroundCnt += 1
            print("location update In Background")
            
            if backgroundCnt == 100 {
                locationManager?.stopUpdatingLocation()
            }
            break
        default:
            print("location update In ForeGround")
        }
    }
}

