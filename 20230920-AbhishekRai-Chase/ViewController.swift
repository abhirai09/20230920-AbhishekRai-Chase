//
//  ViewController.swift
//  20230920-AbhishekRai-Chase
//
//  Created by Abhishek Rai on 20/09/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }


}

