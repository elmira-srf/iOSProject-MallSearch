import Foundation
import UIKit
import CoreLocation
import MapKit



class mallLocation:UIViewController {
 
    //create outlet to the map view ui element
    @IBOutlet weak var mapView: MKMapView!
    
    var currentMallLatitude:Double?
    var currentMallLongitude:Double?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the map
        let centerOfMapCoordinate = CLLocationCoordinate2D(latitude: currentMallLatitude!, longitude: currentMallLongitude!)
        let zoomLevel = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let visibleRegion = MKCoordinateRegion(center: centerOfMapCoordinate, span: zoomLevel)
        self.mapView.setRegion(visibleRegion, animated: true)
        
        // show the mall's location
        self.mapView.showsUserLocation = true
        
        // - create a marker
        let mapMarker = MKPointAnnotation()
        // - coordinate where you want to place the marker
        mapMarker.coordinate = centerOfMapCoordinate
        // - optional: description of the coordinate
        mapMarker.title = "This is my pin!"

        // - place the marker on the map
        mapView.addAnnotation(mapMarker)
        
        let markerToAdd = MKPointAnnotation()
        
        // - 2a. use the lat lng to make the marker
        markerToAdd.coordinate = CLLocationCoordinate2D(latitude: currentMallLatitude!, longitude: currentMallLongitude!)
        
        // 3. Add to the map
        mapView.addAnnotation(markerToAdd)
    }
}
