//
//  MapViewController.swift
//  TheGameShop
//
//  Created by Wojciech Jankowiak on 08/12/2018.
//  Copyright © 2018 Wojciech Jankowiak. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {

    @IBOutlet weak var Map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Map.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(detailGame.latitude), longitude: CLLocationDegrees(detailGame.longitude)), latitudinalMeters: 300, longitudinalMeters: 300), animated: true)
        let annotation = MKPointAnnotation()
        annotation.title = "Lokalizacja gry"
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(detailGame.latitude),longitude: CLLocationDegrees(detailGame.longitude))
        Map.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
}
