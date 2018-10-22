//
//  ViewController.swift
//  Location
//
//  Created by Cedric Woo on 2018-10-16.
//  Copyright © 2018 Cedric Woo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

var lat = 43.4383718
var long = -79.7558213
var radi = 100
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    let locationManager:CLLocationManager = CLLocationManager()
    
    
    @IBOutlet var mapkitView: MKMapView!
    @IBOutlet var informationLabel: UILabel!
    @IBOutlet var geofenceLabel: UILabel!
    @IBOutlet var latField: UITextField!
    @IBOutlet var longField: UITextField!
    @IBOutlet var radField: UITextField!
    @IBOutlet var setbutton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapkitView.delegate = self
        mapkitView.showsPointsOfInterest = true
        mapkitView.showsUserLocation = true
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            
        }
        
        
        let geoFencedRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(lat, long), radius: CLLocationDistance(radi), identifier: "home")
        
        locationManager.startMonitoring(for: geoFencedRegion)
    }
   
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        let latInt = (latField.text! as NSString).integerValue
        let longInt = (longField.text! as NSString).integerValue
        let radInt = (radField.text! as NSString).integerValue
        if latField.text! != ""{
            if -90...90 ~= latInt {
                lat = Double(latInt)
                geofenceLabel.text! = "Latitude Changed"
            }}
        if longField.text! != "" {
            if -180...180 ~= longInt {
                long = Double(longInt)
                geofenceLabel.text! = "Longitude Changed"
            
            }}
        if radField.text! != "" {
        if 50...5000 ~= radInt {
            radi = radInt
            geofenceLabel.text! = "Radius Changed"
            
            }}
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first!
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500,longitudinalMeters: 500)
        mapkitView.setRegion(coordinateRegion, animated: true)
        for currentLocation in locations{
            informationLabel.text! = String("\(index): \(currentLocation)")}}
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        geofenceLabel.text! = String("You are now inside of: \(region.identifier)")
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        geofenceLabel.text! = String("You are now outside of: \(region.identifier)")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        latField.resignFirstResponder()
        longField.resignFirstResponder()
        radField.resignFirstResponder()
        return true
    }
    
}

