//
//  ViewController.swift
//  FollowMyFeet
//
//  Created by Michael Beavis on 7/05/2016.
//  Copyright © 2016 Michael Beavis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.map.showsUserLocation = true
        
        
        //Will access the users location and update when there is a change (Will only work if the user agrees to use location settings
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
//        //Create Long/Lat variables of type CLLocationDegrees
//        let latitude : CLLocationDegrees = -34.405404
//        let longitude : CLLocationDegrees = 150.878409
//        
//        //Delta is difference of latitutudes/longtitudes from one side of screen to another
//        let latDelta : CLLocationDegrees = 0.01 //0.01 is zoomed in, 0.1 is fairly zoomed out
//        let longDelta : CLLocationDegrees = 0.01
//        
//        //combination of 2 deltas, 2 changes between degrees
//        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
//        
//        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
//        
//        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        
//        map.setRegion(region, animated: true)
        
//        
//        //create anotation AKA "Pin"
//        let annotation = MKPointAnnotation()
//        
//        //set location, title and subtitle of annotation
//        annotation.coordinate = location
//        annotation.title = "UOW"
//        annotation.subtitle = "AKA Hell!!!"
//        
//        //add to map
//        map.addAnnotation(annotation)
        
        //allow user to long press on map
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        
        //1 seconds
        uilpgr.minimumPressDuration = 1
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    //action finction recieves var gestureRecogniser
    func action(gestureRecogniser : UIGestureRecognizer){
        print("gesture Recognised")
        
        //location of longpress relative to the map
        let touchPoint = gestureRecogniser.locationInView(self.map)
        
        let newCoordinate : CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        
        let annotation = MKPointAnnotation()
        
        //set location, title and subtitle of annotation
        annotation.coordinate = newCoordinate
        annotation.title = "New Place"
        annotation.subtitle = "Cool...."
        
        //add to map
        map.addAnnotation(annotation)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation : CLLocation = locations[0]
        
        //extracts the user lat/long
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        
        let latDelta : CLLocationDegrees = 0.01 //0.01 is zoomed in, 0.1 is fairly zoomed out
        let longDelta : CLLocationDegrees = 0.01
        
        //combination of 2 deltas, 2 changes between degrees
        let span : MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region : MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

