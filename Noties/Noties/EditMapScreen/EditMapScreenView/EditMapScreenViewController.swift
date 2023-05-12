//
//  EditMapScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import UIKit
import MapKit

final class EditMapScreenViewController: UIViewController {
    
    weak var delegate: EditMapScreenViewListening?

    var note = Note(id: UUID(),
                    title: "No name",
                    text: "Enter the note",
                    picture: UIImage(named: "attach")!,
                    location: CLLocationCoordinate2D(),
                    date: Date())
    
    private let editMapScreenView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = editMapScreenView
        editMapScreenView.delegate = self
        locationManager.delegate = self
        CLLocationManager().requestWhenInUseAuthorization()
        CLLocationManager().requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        DispatchQueue.global().async {
            if (CLLocationManager.locationServicesEnabled()) {
                self.locationManager.requestLocation()
                self.locationManager.startUpdatingLocation()
            }
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withTintColor(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(backEditingLocationButtonDidTap))
    }
    
}

extension EditMapScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            manager.stopUpdatingLocation()
            var coordinates = CLLocationCoordinate2D()
            if note.location.description == CLLocationCoordinate2D().description {
                coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            } else {
                coordinates = note.location
            }
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: coordinates, span: span)
            editMapScreenView.setRegion(region, animated: true)
            
            let date = "\(Calendar.current.component(.day, from: note.date)).\(Calendar.current.component(.month, from: note.date)).\(Calendar.current.component(.year, from: note.date))"
            
            let myPoint = MKPointAnnotation()
            myPoint.coordinate = coordinates
            myPoint.title = note.title
            myPoint.subtitle = date
            
            editMapScreenView.addAnnotation(myPoint)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse, .denied: return
            case .restricted: locationManager.requestWhenInUseAuthorization()
            case .notDetermined: locationManager.requestWhenInUseAuthorization()
            @unknown default: return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

extension EditMapScreenViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let dest = view.annotation!.coordinate
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: dest, span: span)
        mapView.setRegion(region, animated: true)
        view.isDraggable = true
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect annotation: MKAnnotation) {
        self.note.location = annotation.coordinate
    }
    
}

extension EditMapScreenViewController {
    
    @objc private func backEditingLocationButtonDidTap() {
        self.note.location = editMapScreenView.annotations.first?.coordinate ?? CLLocationCoordinate2D()
        self.delegate?.backEditingLocationButtonDidTap(note: self.note)
        self.navigationController?.popViewController(animated: true)
    }
    
}
