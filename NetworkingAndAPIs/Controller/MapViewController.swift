//
//  MapViewController.swift
//  NetworkingAndAPIs
//
//  Created by Laptop World on 23/10/1443 AH.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
   
    //---------------------- LifeCycle ---------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAGc9h1q9ousmo3B_5pW74B-nxwKlTWx54")
        DispatchQueue.main.async {
            let camera = GMSCameraPosition.camera(withLatitude: 26.8206, longitude: 30.8025, zoom: 8.0)
                    let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
                    self.view.addSubview(mapView)
                    // Creates a marker in the center of the map.
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
                    marker.title = "Sydney"
                    marker.snippet = "Australia"
                    marker.map = mapView
        }
    }
}
