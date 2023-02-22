//
//  SelectDeviceViewController.swift
//  
//
//  Created by Maria Nosova on 8/19/22.
//

import UIKit

protocol SelectDeviceDeelegate{
    func changeSelectedDevice(to device: Device)
}

//devices = [Device(id: 1, plants: [flowers[0]], soilMoisture: 45, temperature: 23, light: 4330, battery: 97, status: "Good"), Device(id: 2, plants: [flowers[1]], soilMoisture: 34, temperature: 22, light: 5000, battery: 46, status: "Good"),Device(id: 3, plants: [flowers[2]], soilMoisture: 76, temperature: 19, light: 1000, battery: 23, status: "Good")]



class SelectDeviceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var selectDeviceDelegate: SelectDeviceDeelegate?
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class DeviceTableViewCell: UITableViewCell{
    @IBOutlet weak var devicePlantNameLabel: UILabel!
    @IBOutlet weak var deviceBatteryLabel: UILabel!
    @IBOutlet weak var deviceStatusLabel: UILabel!
    
}

class AddDeviceTableViewCell: UITableViewCell{
    
}

extension SelectDeviceViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //var cell: UITableViewCell
        if indexPath.row < devices.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell") as! DeviceTableViewCell
            cell.devicePlantNameLabel.text = devices[indexPath.row].plants[0].names[0]
            cell.deviceBatteryLabel.text = String(devices[indexPath.row].battery) + " %"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddDeviceCell") as! AddDeviceTableViewCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < devices.count{
            selectDeviceDelegate?.changeSelectedDevice(to: devices[indexPath.row])
        performSegue(withIdentifier: "unwindToMain", sender: self)
        }
        
    }
}
