//
//  MapViewController.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

class MapViewController: CustomViewController, GMUClusterManagerDelegate, GMSMapViewDelegate, GMUClusterRendererDelegate, CLLocationManagerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupClusterManager()
        
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupViews()
    }
    
    private var clusterManager: GMUClusterManager!
    
    var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    var place: Place?
    var currentLat: Double = 0
    var currentLng: Double = 0
    
    func setupLocation() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        currentLat = locValue.latitude
//        currentLng = locValue.longitude
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }
    
    let searchThisAreaButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SEARCH THIS AREA", for: UIControlState.normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        
        return button
    }()
    
    let placeInfoView = PlaceInfoView()
    
    func setupViews() {
        view.addSubview(searchThisAreaButton)
        searchThisAreaButton.frame = CGRect(x: view.center.x - 75, y: 72, width: 150, height: 50)
        searchThisAreaButton.addTarget(self, action: #selector(handleSearchArea), for: UIControlEvents.touchUpInside)
        
        view.addSubview(placeInfoView)
        placeInfoView.frame = CGRect(x: 16, y: view.frame.height - 141, width: view.frame.width - 32, height: 125)
        placeInfoView.isHidden = true

        placeInfoView.detailButton.addTarget(self, action: #selector(handleDetail), for: UIControlEvents.touchUpInside)
    }
    
    @objc func handleDetail() {
        let detailViewController = DetailViewController(collectionViewLayout: UICollectionViewFlowLayout())
        detailViewController.id = place?.id
        detailViewController.place = place
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
        let longitude = mapView.camera.target.longitude
        
        currentLng = longitude
        currentLat = latitude
        print(latitude)
        print(longitude)
    }
    // TODO
    @objc func handleSearchArea() {
        self.mapView.clear()
        clusterManager.clearItems()
        var bounds = GMSCoordinateBounds()
        let camera = GMSCameraPosition.camera(withLatitude: currentLat,
                                              longitude: currentLng,
                                              zoom: 14)
        getPlacesNearBy(lat: Float(currentLat), lng: Float(currentLng), type: "cafe", radius: 200) { (places) in
            guard let places = places else{return}
            
            for place in places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: place.lat!, longitude: place.lng!)
                marker.map = self.mapView
//                marker.title = "Dep trai"
                //                marker.icon = UIImage(named: "image")
                bounds = bounds.includingCoordinate(marker.position)
                
                let item = Item(position: CLLocationCoordinate2DMake(place.lat!, place.lng!), place: place)
                self.clusterManager.add(item)
            }
            
            if places.count > 0{
                self.mapView.camera = camera
                let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
                self.mapView.animate(with: update)
                self.clusterManager.cluster()
            }
        }
    }
    
    func setupClusterManager(){
        // Set up the cluster manager with default icon generator and renderer.
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        renderer.delegate = self
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    // MARK: - GMUClusterManagerDelegate
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
        return true
    }
    
    // MARK: - GMUMapViewDelegate
    
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
//        if let item = marker.userData as? Item{
//            let iconView = CustomMarkerIconView(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
//            iconView.carImageView.image = item.image
//            iconView.vehiclePlateLabel.text = item.title
//            marker.iconView = iconView
//            marker.title = item.title
            
            //            marker.title = item.title
            //            marker.icon = item.image
            //            marker.groundAnchor = CGPoint(x: 0.2, y: 0.2)
//        }
        //        }else{
        //            let item = marker.userData as? GMUStaticCluster
        //            for it in item?.items as! [Item]{
        //                let iconView = CustomMarkerIconView(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        //                iconView.carImageView.image = it.image
        //                iconView.vehiclePlateLabel.text = it.title
        //                marker.iconView = iconView
        //
        //            }
        //        }
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        placeInfoView.isHidden = false
        if let item = marker.userData as? Item, let place = item.place{
            self.place = place
            placeInfoView.placeNameLabel.text = place.name
            placeInfoView.placeTypeLabel.text = place.type
            placeInfoView.addressLabel.text = place.address
            placeInfoView.ratingLabel.text = String(place.rate!)
            if let url = place.photoUrl {
                placeInfoView.placeImageView.loadImageUsing(urlString: url)
            } else {
                placeInfoView.placeImageView.image = UIImage(named: "qr_code")
            }
        }
        return true
    }
    
    // MARK: - Private
    
    override func loadView() {
//        navigationItem.title = NSLocalizedString("Supervision", comment: "")
//        self.customProgressBar.startAnimation()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.868,
                                              longitude: 151.2086,
                                              zoom: 14)
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        var bounds = GMSCoordinateBounds()
        
        getPlacesNearBy(lat: 21.028511, lng: 105.804817, type: "cafe", radius: 200) { (places) in
            guard let places = places else{return}
            
            for place in places {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: place.lat!, longitude: place.lng!)
                marker.map = self.mapView
                marker.title = "Dep trai"
//                marker.icon = UIImage(named: "image")
                bounds = bounds.includingCoordinate(marker.position)
                
                let item = Item(position: CLLocationCoordinate2DMake(place.lat!, place.lng!), place: place)
                self.clusterManager.add(item)
            }
            
            if places.count > 0{
                self.mapView.camera = camera
                let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
                self.mapView.animate(with: update)
                self.clusterManager.cluster()
            }
        }
        
        view = mapView

    }
    
    func reloadView(){
        self.mapView.clear()
        clusterManager.clearItems()
        var bounds = GMSCoordinateBounds()
//        if filteredCars.count == cars.count{
//            for car in self.filteredCars{
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: car.Lat!, longitude: car.Lng!)
//
//                let iconView = CustomMarkerIconView(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
//                iconView.carImageView.image = UIImage(named: imageStringForCar(car: car))
//                iconView.vehiclePlateLabel.text = car.VehiclePlate
//                marker.iconView = iconView
//
//                //            marker.icon = UIImage(named: imageStringForCar(car: car))
//                marker.title = car.VehiclePlate
//                //                bounds = bounds.includingCoordinate(marker.position)
//                //
//                //                marker.map = mapView
//                let item = Item(position: CLLocationCoordinate2DMake(car.Lat!, car.Lng!), title: car.VehiclePlate!, image: UIImage(named: imageStringForCar(car: car))!)
//                self.clusterManager.add(item)
//            }
//            //
//            self.clusterManager.cluster()
//            //
//        }else{
//            for car in self.filteredCars{
//                let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2D(latitude: car.Lat!, longitude: car.Lng!)
//
//                let iconView = CustomMarkerIconView(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
//                iconView.carImageView.image = UIImage(named: imageStringForCar(car: car))
//                iconView.vehiclePlateLabel.text = car.VehiclePlate
//                marker.iconView = iconView
//
//                //            marker.icon = UIImage(named: imageStringForCar(car: car))
//                marker.title = car.VehiclePlate
//                bounds = bounds.includingCoordinate(marker.position)
//
//                marker.map = mapView
//                //            let item = Item(position: CLLocationCoordinate2DMake(car.Lat!, car.Lng!), title: car.VehiclePlate!, image: UIImage(named: imageStringForCar(car: car))!)
//                //            self.clusterManager.add(item)
//            }
//            //
//            //        self.clusterManager.cluster()
//
    
    }
    
}

class Item: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
//    var title: String!
//    var image: UIImage!
//    var rotation: Double?
    var place: Place?
    
    init(position: CLLocationCoordinate2D, place: Place) {
        self.position = position
//        self.title = title
//        self.image = image
        self.place = place
    }
    
}













