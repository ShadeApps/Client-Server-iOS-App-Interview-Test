//
//  PlaceMarker.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 27.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: CLLocationCoordinate2D
    let name: String
    init(place: CLLocationCoordinate2D, name : String) {
        self.place = place
        self.name = name
        super.init()

        position = place
        icon = UIImage(named:UIKeys.MapIconTitle)
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = kGMSMarkerAnimationPop
    }
}