//
//  MapsScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import UIKit
import MapKit

protocol MapsScreenViewModelListening: AnyObject {
    func initializeMapsScreenView(notes: [Note])
    func pushEditNoteScreenViewController(note: Note?)
}

protocol MapsScreenViewListening: AnyObject {
    func editButtonDidTap(noteCoordinates: CLLocationCoordinate2D)
}

protocol LocationTapListening: AnyObject {
    func focusOnNote(note: Note)
}

final class MapsScreenViewController: UIViewController {
    
    weak var delegate: MapsScreenViewModelListening?

    var tappedNote = Note(id: UUID(),
                    title: "No name",
                    text: "Enter the note",
                    picture: UIImage(named: "attach")!,
                    location: CLLocationCoordinate2D(),
                    date: Date())
    
    private let mapsScreenView = MapsScreenView()
    private let mapsScreenViewModel = MapsScreenViewModel()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapsScreenView
        mapsScreenView.delegate = self
        mapsScreenView.editDelegate = self
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
        mapsScreenViewModel.delegate = self
        mapsScreenViewModel.getNotes()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapsScreenViewModel.getNotes()
    }
    
}

extension MapsScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            manager.stopUpdatingLocation()

            var tappedCoordinates = CLLocationCoordinate2D()
            if tappedNote.location.description == CLLocationCoordinate2D().description {
                tappedCoordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            } else {
                tappedCoordinates = tappedNote.location
            }
            
            let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
            let region = MKCoordinateRegion(center: tappedCoordinates, span: span)
            mapsScreenView.setRegion(region, animated: true)
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

extension MapsScreenViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        let dest = view.annotation!.coordinate
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: dest, span: span)
        mapView.setRegion(region, animated: true)
        mapsScreenView.toggleButton()
        mapsScreenView.setCoordinates(coordinates: view.annotation?.coordinate ?? CLLocationCoordinate2D())
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        mapsScreenView.toggleButton()
    }
    
}

extension MapsScreenViewController: MapsScreenViewModelListening {
    
    func initializeMapsScreenView(notes: [Note]) {
        let annotations = mapsScreenView.annotations
        mapsScreenView.removeAnnotations(annotations)
        for note in notes {
            if !(note.location.description == CLLocationCoordinate2D().description) {
                                
                let date = "\(Calendar.current.component(.day, from: note.date)).\(Calendar.current.component(.month, from: note.date)).\(Calendar.current.component(.year, from: note.date))"
                
                let point = MKPointAnnotation()
                point.coordinate = note.location
                point.title = note.title
                point.subtitle = date
                
                mapsScreenView.addAnnotation(point)
            }

        }
        
    }
    
    func pushEditNoteScreenViewController(note: Note?) {
        let editNoteScreenViewController = EditNoteScreenViewController()
        editNoteScreenViewController.configureEditNoteScreenView(note: note)
        self.tabBarController?.navigationController?.pushViewController(editNoteScreenViewController, animated: true)
    }
    
}

extension MapsScreenViewController: MapsScreenViewListening {
    
    func editButtonDidTap(noteCoordinates: CLLocationCoordinate2D) {
        self.mapsScreenViewModel.getNoteByCoordinates(coordinate: noteCoordinates)
    }
    
}

extension MapsScreenViewController: LocationTapListening {
    
    func focusOnNote(note: Note) {
        let dest = note.location
        let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: dest, span: span)
        self.mapsScreenView.setRegion(region, animated: true)
    }
    
}
