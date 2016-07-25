//
//  MainViewController.swift
//  SaitamaRent
//
//  Created by Сергей Грищёв on 26.06.16.
//  Copyright © 2016 ShadeApps. All rights reserved.
//

import UIKit
import GoogleMaps
import EZAlertController

class MainViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mainMapView: GMSMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mainMapView.delegate = self

        PlacesNetWorker.loadPlaces { (isDone, errorText) in
            if !isDone {
                EZAlertController.alert(NSLocalizedString(UIStrings.ServerError, comment: ""), message: (errorText != nil) ?errorText! : NSLocalizedString(UIStrings.ServerErrorLong, comment: ""))
                return
            }
            MapWorker.addMarkers(DataPersistor.retrieveArray(PersistorKeys.ResultsKey) as! Array<Dictionary<String,AnyObject>>, map: self.mainMapView)
        }
    }

    override func viewDidAppear(animated: Bool) {
        self.title = NSLocalizedString(UIStrings.RentBikeTitle, comment: "")
    }

    // MARK: - Input Actions
    @IBAction func btnCenterMapTapped(sender: AnyObject?){
        if let coordinate = self.mainMapView.myLocation?.coordinate{
            self.mainMapView.camera = GMSCameraPosition(target: coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        }
    }

     @IBAction func btnLogoutTapped(sender: AnyObject?){
        EZAlertController.alert(NSLocalizedString(UIStrings.LogOut, comment: ""), message: NSLocalizedString(UIStrings.LogOutLong, comment: ""), buttons:[NSLocalizedString(UIStrings.LogOutOptionNo, comment: ""), NSLocalizedString(UIStrings.LogOutOptionYes, comment: "")]) { (UIAlertAction, index) in
            if index == 1 {
                SessionWorker.performLogOut()
            }
        }
    }

    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        let ourMarker = marker as! PlaceMarker
        EZAlertController.alert(NSLocalizedString(UIStrings.RentBikeAlertTitle, comment: ""), message:NSLocalizedString(UIStrings.RentBikeAlertBody, comment: "")+ourMarker.name, buttons:[NSLocalizedString(UIStrings.RentBikeOptionNo, comment: ""), NSLocalizedString(UIStrings.RentBikeOptionYes, comment: "")]) { (UIAlertAction, index) in
            if index == 1 {
                perform_after(0.5, closure: {
                    self.presentViewController(UIStoryboard(name: StoryboardID.Rent, bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
                })

            }
        }
        return true
    }

}

// MARK: - CLLocationManagerDelegate and Map SetUp
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
            self.mainMapView.myLocationEnabled = true
        }
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.mainMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
}