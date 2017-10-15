//
//  ViewController.swift
//  Location Aware
//
//  Created by dly on 10/15/17.
//  Copyright © 2017 dly. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Specify delegate
        locationManager.delegate = self
        
        //Accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //Request permission to use location while app is in use
        locationManager.requestWhenInUseAuthorization()
        
        //Start updating location after permission is granted
        locationManager.startUpdatingLocation()
    }
    
    //Function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        let userLocation: CLLocation = locations[0]
        
        //Setting the labels with data
        latitudeLabel.text = String(userLocation.coordinate.latitude)
        longitudeLabel.text = String(userLocation.coordinate.longitude)
        courseLabel.text = String(userLocation.course)
        speedLabel.text = String(userLocation.speed)
        altitudeLabel.text = String(userLocation.altitude)
        
        //Geocoder is going from address to location(latitude and longitude). Need to reverse it to get an address.
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0] {
                
                    var address = ""
                    
                    //Number
                    if placemark.subThoroughfare != nil {
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    //Street
                    if placemark.thoroughfare != nil {
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    //City
                    if placemark.locality != nil {
                        address += placemark.locality! + ", "
                    }
                    
                    //State
                    if placemark.administrativeArea != nil {
                        address += placemark.administrativeArea! + " "
                    }
                    
                    //ZIP Code
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                    }
                    
                    //Country
                    if placemark.country != nil {
                        address += placemark.country!
                    }
        
                //Set the addressLabel
                self.addressLabel.text = address
                }
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

