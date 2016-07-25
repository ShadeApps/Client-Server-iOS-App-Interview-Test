//
//  MapWorker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 27.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import GoogleMaps

class MapWorker: NSObject {
    class func addMarkers(markersArray : Array<Dictionary<String,AnyObject>>, map: GMSMapView){
        for dictionary: Dictionary<String,AnyObject> in markersArray {
            let marker = PlaceMarker.init(place: CLLocationCoordinate2DMake(dictionary["location"]!["lat"] as! Double, dictionary["location"]!["lng"] as! Double), name: dictionary["name"] as! String)
            marker.map = map
        }
    }
}