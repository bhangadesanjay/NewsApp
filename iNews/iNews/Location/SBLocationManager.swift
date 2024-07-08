//
//  SBLocationManager.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 05/07/24.
//

import Foundation
import CoreLocation
import UIKit

private let _locationManager = SBLocationManager()

class SBLocationManager: NSObject, CLLocationManagerDelegate{
    var locationManager: CLLocationManager?
    var location : CLLocation?
    let geoCoder = CLGeocoder()
    var countryCode:String?

    class func sharedInstance() -> SBLocationManager{
        return _locationManager
    }
    
    override init(){
        super.init()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func getCountryCode() ->String {
        return countryCode ?? "in"
    }
    
    func startListening(){
        
        let manager = CLLocationManager()
        let authorizationStatus:CLAuthorizationStatus
        if #available(iOS 14, *){
            authorizationStatus = manager.authorizationStatus
        }else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if (authorizationStatus == .notDetermined){
            if locationManager?.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) ?? false {
                locationManager?.requestWhenInUseAuthorization()
            }else {
                startUpdateLocation()
            }
        }else if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways{
            startUpdateLocation()
        }else{
            let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
            let view : UIViewController = window?.rootViewController ?? UIViewController()
            view.showDefautAlert(message:"EnableLocation".localize())
        }
    }
    
    func getCountryLocal(){
        let countryLocale = NSLocale.current
        countryCode = countryLocale.identifier
    }
    
    func startUpdateLocation(){
        locationManager!.startUpdatingLocation()
    }
    
    func locationManager(_ manager:CLLocationManager, didChangeAuthorization status:CLAuthorizationStatus){
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            startUpdateLocation()
        }else{
            //            let view : UIViewController = UIApplication.shared.keyWindow!.rootViewController ?? UIViewController()
            //            view.showDefautAlert(message:"EnableLocation".localize())
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else { return }

        geoCoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            guard let currentLocPlacemark = placemarks?.first else {
                self.getCountryLocal()
                return
            }
            self.countryCode = currentLocPlacemark.isoCountryCode
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    deinit {
        locationManager = nil
    }
}
