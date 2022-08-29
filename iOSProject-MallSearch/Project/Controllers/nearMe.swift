import Foundation
import UIKit
import MapKit
import CoreLocation

class nearME:UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    // location manager
    var locationManager:CLLocationManager!
    
    var mallsList:[Malls]=[]
    let MallDB = MallsDatabase.shared
    var mallsName:[String]=[]
    
    // MARK: Geocoder variable
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // configure the map
        let centerOfMapCoordinate = CLLocationCoordinate2D(latitude: 37.3319, longitude: -122.0302)
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let visibleRegion = MKCoordinateRegion(center: centerOfMapCoordinate, span: zoomLevel)
        self.mapView.setRegion(visibleRegion, animated: true)
        
        // show the user's location
        self.mapView.showsUserLocation = true
        
        // - create a marker
        let mapMarker = MKPointAnnotation()
        // - coordinate where you want to place the marker
        mapMarker.coordinate = centerOfMapCoordinate
        // - optional: description of the coordinate
        mapMarker.title = "You Are Here!"
        // - place the marker on the map
        mapView.addAnnotation(mapMarker)
        
        self.mallsList = self.MallDB.getAllTorontoMalls()
        self.mallsList.append(contentsOf: self.MallDB.getAllOttawaMalls())
        self.mallsList.append(contentsOf: self.MallDB.getAllCalgaryMalls())
        self.mallsList.append(contentsOf: self.MallDB.getAllVancouverMalls())
        self.mallsList.append(contentsOf: self.MallDB.getAllMontrealMalls())
        
        for malls in mallsList{
            let x = malls.name
            self.mallsName.append(contentsOf: [x])
        }
        
        getDirections(enterdLocations: mallsName)
  
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.bounds
    }
    
    // this function wil run EVERY time the user location changes/update
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 1. get the last known location
        if let lastKnownLocation =  locations.first {
            let lat = lastKnownLocation.coordinate.latitude
            let lng = lastKnownLocation.coordinate.longitude
            print("Current location: \(lat), \(lng), current speed: \(lastKnownLocation.speed)")
            
            // 2. update the visible map region to match where the user is
            let updatedCenterOfMapCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let updatedVisibleRegion = MKCoordinateRegion(center: updatedCenterOfMapCoordinate, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            self.mapView.setRegion(updatedVisibleRegion, animated:true)
        }
    }
    
    func getNearMall(mall:String){
            self.geocoder.geocodeAddressString(mall){
                (result,error) in
                if error != nil {
                    
                    print("An error occured during forward geocoding")
                }//if error
                else {
                    // we found some results
                    print("Number of results found: \(result!.count)")
                    
                    let locationResult:CLPlacemark = result!.first!
                    let lat = locationResult.location?.coordinate.latitude
                    let lng = locationResult.location?.coordinate.longitude
                    //print(malls.name)
                    self.addPin(mall:mall,lat: lat!, lng: lng!)
                }// else
            }
    }//getNearMall
    
    func addPin(mall:String,lat:Double,lng:Double){
        print(lat,lng)
        //Construct the map marker
        let markerToAdd = MKPointAnnotation()
        //use the lat lng to make the marker
        markerToAdd.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        //  marker description
        markerToAdd.title = mall
        // Add to the map
        mapView.addAnnotation(markerToAdd)
        print("pin added")
        
    }
    
    func getDirections(enterdLocations:[String])  {
        // array has the address strings
        var markerToAdd = [MKPointAnnotation]()
        for item in enterdLocations {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(item, completionHandler: {(placemarks, error) -> Void in
                if((error) != nil){
                    print("Error", error)
                }
                if let placemark = placemarks?.first {

                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate

                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = coordinates
                    dropPin.title = item
                    self.mapView.addAnnotation(dropPin)
                    self.mapView.selectAnnotation( dropPin, animated: true)

                    markerToAdd.append(dropPin)
                    //add this if you want to show them all
                    self.mapView.showAnnotations(markerToAdd, animated: true)
                }
            })
        }
    }
}
