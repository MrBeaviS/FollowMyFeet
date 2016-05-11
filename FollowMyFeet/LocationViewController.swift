//
//  LocationViewController.swift
//  FollowMyFeet
//
//  Created by Nicholas Judd on 11/05/2016.
//  Copyright © 2016 Michael Beavis. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LocationViewController: UITableViewController {
    var data: dataAccess = dataAccess.sharedInstance
    var locs: [Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test")
        locs = data.getAllLocations()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locs!.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
            cell.textLabel!.text = "All Colections"
            return cell;
    }
    
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let cellID = collectionTable.cellForRowAtIndexPath(indexPath)! as UITableViewCell
            if (indexPath.row != 0){
                SBM.findAndDeleteCollection(cellID.textLabel!.text!)
                collectionTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
    }*/
}