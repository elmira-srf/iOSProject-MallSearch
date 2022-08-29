import Foundation
import UIKit
import CoreLocation

class theMall:UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMall?.stores!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell to display
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        // Get the current mall's store for this row
        let rowData = currentMall?.stores![indexPath.row]
        cell.textLabel?.text = rowData?.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let StoreScreen = storyboard?.instantiateViewController(identifier: "StoreDetailScreen") as? theStore else {
            print("Cannot find next screen")
            return
        }
        // send selected mall's information
        StoreScreen.currentStore = currentMall?.stores![indexPath.row]
        StoreScreen.currentMall = currentMall

        //Go to  Activity screen
        self.navigationController?.pushViewController(StoreScreen, animated: true)
        
        //Go to  Activity screen
        return
    }
    
    // MARK: Geocoder variable
    let geocoder = CLGeocoder()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var mallNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationButton: UIButton!
    
    
    @IBAction func locationPressed(_ sender: Any)
    {
        let mallName = currentMall?.name
        self.geocoder.geocodeAddressString(mallName!) {
            //  ([CLPlacemark]?, Error?) in
            (resultsList, error) in
            
            if let err = error {
                print("An error occured during forward geocoding")
            }
            else {
                // we found some results
                print("Number of results found: \(resultsList!.count)")
                // extract the first result from the array
                // output it to the screen
                let locationResult:CLPlacemark = resultsList!.first!
                
                let lat = locationResult.location?.coordinate.latitude
                let lng = locationResult.location?.coordinate.longitude
                
                if let lat = lat, let lng = lng {
                    print("latitude: \(lat) longitude: \(lng)")
                    print("go to map Screen")
                    guard let MallLocationScreen = self.storyboard?.instantiateViewController(identifier: "MallLocationScreen") as? mallLocation else {
                        print("Cannot find Mall Location Screen")
                        return
                    }
                    // send selected Mall's Location's Information
                    MallLocationScreen.currentMallLatitude = lat
                    MallLocationScreen.currentMallLongitude = lng

                    //Go to  Mall Location Screen
                    self.navigationController?.pushViewController(MallLocationScreen, animated: true)
                    return
                }
                else {
                    print("The coordinates are null")
                }
            }
        }
    }
    
  
    var currentMall:Malls?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mallNameLabel.text = currentMall?.name
        
        self.locationButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
        if currentMall?.stores?.count ?? 0 > 0{
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
}
