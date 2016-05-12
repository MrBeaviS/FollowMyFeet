//
//  Location+CoreDataProperties.swift
//  FollowMyFeet
//
//  Created by Nicholas Judd on 11/05/2016.
//  Copyright © 2016 Michael Beavis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Location {

    @NSManaged var longitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longDelta: NSNumber?
    @NSManaged var latDelta: NSNumber?
<<<<<<< HEAD
=======
    @NSManaged var name: String?
    @NSManaged var info: String?
    @NSManaged var dateCreated: NSDate?
>>>>>>> 8c212f7579cd3e22e0ac731d3f18a6fc1476a551
    @NSManaged var path: Path?

}
