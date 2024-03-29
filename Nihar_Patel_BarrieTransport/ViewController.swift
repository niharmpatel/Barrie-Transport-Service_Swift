//
//  ViewController.swift
//  Nihar_Patel_BarrieTransport
//
//  Created by Nihar Patel on 2019-11-20.
//  Copyright © 2019 Nihar Patel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    
    var model = NP_BTS_Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let barrieLatitude = 44.389355
        let barrieLongitude = -79.690331

        let barrieLocation = CLLocationCoordinate2D(latitude: barrieLatitude, longitude: barrieLongitude)
        let delta = 0.2
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        
        let region = MKCoordinateRegion(center: barrieLocation, span: span)
        
        mapview.setRegion(region, animated: true)
        
        for driver in model.drivers{
            print ("Driver name is \(driver.key)")
            let random1 =  Double.random(in: -0.05...0.05)
            let random2 =  Double.random(in: -0.05...0.05)
            let annotation = MKPointAnnotation()
            
            let annotationLocation = CLLocationCoordinate2D(latitude: barrieLatitude + random1, longitude: barrieLongitude + random2)
            
            annotation.coordinate = annotationLocation
            annotation.title = driver.key
            annotation.subtitle = driver.value
            mapview.addAnnotation(annotation)
 
            mapview.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        }
        
        
    }

    class CustomAnnotationView: MKMarkerAnnotationView {
        
        override init(annotation: MKAnnotation?, reuseIdentifier: String?){
            super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
            
            self.canShowCallout = true
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
            
            button.setTitle("call", for: .normal)
            button.setTitleColor(UIColor.blue, for: .normal)
            
            button.addTarget(self, action: #selector(CustomAnnotationView.callTheNumber), for: .touchUpInside)
            
            self.rightCalloutAccessoryView = button
        }
        
        @objc func  callTheNumber (sender: UIButton)  {
            print ("call the number")
            let phoneNumber = (annotation?.subtitle)!
            let urlString = "tel://" + phoneNumber!
            
            if let url = URL(string: urlString){
                UIApplication.shared.open(url)
            }
            
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }

}

