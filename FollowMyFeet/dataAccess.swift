//
//  dataAccess.swift
//  FollowMyFeet
//
//  Created by Nicholas Judd on 10/05/2016.
//  Copyright © 2016 Michael Beavis. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import MapKit

class dataAccess {
    static let sharedInstance = dataAccess()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
<<<<<<< HEAD
    func createLocation(location: CLLocationCoordinate2D, latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) {
=======
    func createLocation(location: CLLocationCoordinate2D, latDelta: CLLocationDegrees, longDelta: CLLocationDegrees, name: String, info: String) {
>>>>>>> 8c212f7579cd3e22e0ac731d3f18a6fc1476a551
        print(location)
        let storedLocation: Location = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: managedObjectContext) as! Location
        storedLocation.latitude = location.latitude
        storedLocation.longitude = location.longitude
        storedLocation.latDelta = latDelta
        storedLocation.longDelta = longDelta
<<<<<<< HEAD
=======
        storedLocation.name = name
        storedLocation.info = info
        storedLocation.dateCreated = NSDate()
>>>>>>> 8c212f7579cd3e22e0ac731d3f18a6fc1476a551
        self.saveData()
    }
    
    func getAllLocations() -> [Location] {
        let fetchRequest = NSFetchRequest(entityName: "Location")
        do {
            let fetchedLocation: [Location] = try self.managedObjectContext.executeFetchRequest(fetchRequest) as! [Location]
            return fetchedLocation
        }catch {
            print("Couldn't get any Locations!")
            return[]
        }
    }
    
    func saveData() {
        do {
            try managedObjectContext.save()
        }catch {
            print("error saving data")
        }
    }
    
    func testDelete(location: Location) {
        self.managedObjectContext.deleteObject(location)
    }
}