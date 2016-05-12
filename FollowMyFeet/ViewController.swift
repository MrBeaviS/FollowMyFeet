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
import Foundation
class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBAction func returnToLoc(sender: AnyObject) {
        latitude = nil
        longitude = nil
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var map: MKMapView!
    
    var annotationName: String?
    var annotationInfo: String?
    let locationManager = CLLocationManager()
    var data: dataAccess = dataAccess.sharedInstance
    var locs: [Location]?
    var latitude: NSNumber?
    var longitude: NSNumber?
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*self.map.showsUserLocation = true
        
        locs = data.getAllLocations()
        for i in locs!{
            placePins(i)
            //data.testDelete(i)
        }
        //Will access the users location and update when there is a change (Will only work if the user agrees to use location settings
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if (latitude != nil && longitude != nil){
        let initialLocation = CLLocation(latitude: CLLocationDegrees(latitude!), longitude: CLLocationDegrees(longitude!))
        centerMapOnLocation(initialLocation)
        }*/
        // 1. The ViewController is the delegate of the MKMapViewDelegate protocol
        map.delegate = self
        
        // 2. Set the latitude and longtitude of the locations
        let sourceLocation = CLLocationCoordinate2D(latitude: 40.759011, longitude: -73.984472)
        let destinationLocation = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.985564)
        
        // 3. Create placemark objects containing the location's coordinates
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        // 4. MKMapitems are used for routing. This class encapsulates information about a specific point on the map
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        // 5. Annotations are added which shows the name of the placemarks
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Times Square"
        
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Empire State Building"
        
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        // 6. The annotations are displayed on the map
        self.map.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true )
        
        // 7. The MKDirectionsRequest class is used to compute the route.
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .Automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        // 8.The route will be drawn using a polyline as a overlay view on top of the map. The region is set so both locations will be visible
        directions.calculateDirectionsWithCompletionHandler {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            self.map.addOverlay((route.polyline), level: MKOverlayLevel.AboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.map.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        
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
        
        pinCreate(newCoordinate)
        
        //set location, title and subtitle of annotation
        
        
        //add to map
        
        
    }
    
    func pinCreate(newCoordinate: CLLocationCoordinate2D){
        var annotationName: String?
        var annotationInfo: String?
        let addLocationAlert = UIAlertController(title:  "Add a new Location",message: "Location Details", preferredStyle: UIAlertControllerStyle.Alert)
        addLocationAlert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Location Name"
        }
        addLocationAlert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Location Info"
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
            addLocationAlert.dismissViewControllerAnimated(true, completion: nil)
        }
        let createButton = UIAlertAction(title: "Create", style: .Default) { (alert: UIAlertAction!) -> Void in
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinate
            if let text = addLocationAlert.textFields![0].text where !text.isEmpty {
                annotationName = text
            }
            if let text = addLocationAlert.textFields![1].text where !text.isEmpty {
                annotationInfo = text
            }
            annotation.title = annotationName
            annotation.subtitle = annotationInfo
            self.map.addAnnotation(annotation)
            self.data.createLocation(newCoordinate, latDelta: 0.01, longDelta: 0.01, name: annotationName!, info: annotationInfo!)
        }

        addLocationAlert.addAction(cancelButton)
        addLocationAlert.addAction(createButton)
        presentViewController(addLocationAlert, animated:true, completion: nil)

    }
    
    func placePins(loc: Location){
        let annotation = MKPointAnnotation()
        let latitude: CLLocationDegrees = loc.latitude as! CLLocationDegrees
        let longitude: CLLocationDegrees = loc.longitude as! CLLocationDegrees
        //set location, title and subtitle of annotation
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        annotation.coordinate = location
        annotation.title = loc.name
        annotation.subtitle = loc.info
        map.addAnnotation(annotation)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //print(locations)
        
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

