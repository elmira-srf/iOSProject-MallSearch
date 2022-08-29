import Foundation
import UIKit
import Combine

class store: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mallsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell to display
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        // Get the data for this row
        let rowData = mallsList[indexPath.row]
        cell.textLabel?.text = rowData.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You clicked on Mall #: \(indexPath.row)")
        
        guard let MallScreen = storyboard?.instantiateViewController(identifier: "MallDetailsScreen") as? theMall else {
            print("Cannot find next screen")
            return
        }
        // send selected mall's information
        MallScreen.currentMall = mallsList[indexPath.row]
        //Go to  Mall screen
        self.navigationController?.pushViewController(MallScreen, animated: true)
        
        //Go to  Mall screen
        return
    }


   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //number of columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //number of rows of data
        return cities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return cities[row]
       }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        
        switch (cities[row]){
        case "Montreal":
            self.mallsList = MallDB.getAllMontrealMalls()
        case "Calgary":
            self.mallsList = MallDB.getAllCalgaryMalls()
        case "Ottawa":
            self.mallsList = MallDB.getAllOttawaMalls()
        case "Vancouver":
            self.mallsList = MallDB.getAllVancouverMalls()
        default:
            self.mallsList = MallDB.getAllTorontoMalls()
            
        }
        
        
        let selectedIndex = self.picker.selectedRow(inComponent: 0)
         print(cityList[selectedIndex].name)
        self.tableView.reloadData()
        
    }
    
    
    // MARK: Outlets
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    var cityList:[City]=[]
    var mallsList:[Malls]=[]
    let MallDB = MallsDatabase.shared
    let cities :[String] = ["Toronto","Montreal","Calgary","Ottawa","Vancouver"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.picker.dataSource = self
        self.picker.delegate = self
 
        self.cityList = [City(name: "Toronto",
                              malls: MallDB.getAllTorontoMalls()),
                         City(name: "Montreal",
                              malls: MallDB.getAllMontrealMalls()),
                         City(name: "Calgary",
                              malls: MallDB.getAllCalgaryMalls()),
                         City(name: "Ottawa",
                              malls: MallDB.getAllOttawaMalls()),
                         City(name: "Vancouver",
                              malls: MallDB.getAllVancouverMalls()),
        ]
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.mallsList = MallDB.getAllTorontoMalls()
        
    }
    
    
    // MARK: Actions
    
    @IBAction func btnMallsNearMePushed(_ sender: Any) {
        print("go to Malls Near Me Screen")
        guard let NearMallsScreen = self.storyboard?.instantiateViewController(identifier: "NearMallsScreen") as? nearME else {
            print("Cannot find Malls Near Me Screen")
            return
        }
        //Go to  Malls Near Me Screen
        self.navigationController?.pushViewController(NearMallsScreen, animated: true)
        return
        
    }
}
