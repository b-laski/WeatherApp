//
//  MapView.swift
//  WeatherApp
//
//  Created by Bartomiej Łaski on 15/10/2018.
//  Copyright © 2018 Bartomiej Łaski. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    var mapView = MKMapView()
    var data: [Double]? {
        willSet(newValue) {
            data = newValue
            print(data?.description)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.frame = view.frame
        
        mapView.mapType = MKMapType.hybrid
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        view.addSubview(mapView)
        
        if(data != nil){
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: data![1], longitude: data![0]), span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}
