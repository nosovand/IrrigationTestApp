//
//  MainScreenViewController.swift
//  
//
//  Created by Maria Nosova on 8/19/22.
//

import UIKit

//var flowers: [Flower] = [] //delete
var plants: [Plant] = []

func generateFlowers(with nameList: [[String]]) -> [Plant]{
    var flowers: [Plant] = []
    for names in nameList {
        flowers.append(Plant(names: names, minSoilMoisture: Int.random(in: 20...50) , maxSoilMoisture: Int.random(in: 50...70) , minTemperature: Int.random(in: 17...22), maxTemperature: Int.random(in: 22...33), minLight: Int.random(in: 100...2000), maxLight: Int.random(in: 2000...20000)))
    }
    return flowers
}

class MainScreenViewController: UIViewController {

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        if seg.identifier == "unwindToMain3"{
        selectedDevice = devices.last
        refreshScreenData()
            print("test4")
        }
       /* if seg.identifier == "unwindToMain4"{
            if devicesAvailable(){
                selectedDevice = devices[0]
                refreshScreenData()
                print("test3")
            }
            else{
                performSegue(withIdentifier: "addFirstDevice", sender: self)
                print("test2")
            }
        }*/
    }
    
    @IBOutlet weak var selectedPlantName: UIButton!
    @IBOutlet weak var lightButton: RoundedButton!
    @IBOutlet weak var temperatureButton: RoundedButton!
    @IBOutlet weak var soilMoistureButton: RoundedButton!
    @IBOutlet weak var batteryButton: RoundedButton!
    @IBOutlet weak var statusButton: RoundedButton!
    
    var selectedDevice: Device?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plants = generateFlowers(with: flowersNames)
        plants = plants.sorted{
           $0.names[0] < $1.names[0]
        }
        if devicesAvailable() == false {
        performSegue(withIdentifier: "addFirstDevice", sender: self)
        }

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        devices = _devices
        if devicesAvailable() == false {
        performSegue(withIdentifier: "addFirstDevice", sender: self)
        }
        else{
        selectedDevice = devices[0]
        refreshScreenData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? SelectDeviceViewController, segue.identifier == "openDeviceList"{
            vc.selectDeviceDelegate = self
        }
        if let vc = segue.destination as? DeviceSettingsViewController, segue.identifier == "deviceSettings"{
            vc.selectedDevice = self.selectedDevice
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func refreshScreenData(){
       
    selectedPlantName.setTitle(selectedDevice!.plants[0].names[0], for: .normal)
        lightButton.setTitle(" " + String(selectedDevice!.light) + " lx", for: .normal)
        temperatureButton.setTitle(" " + String(selectedDevice!.temperature) + "°", for: .normal)
        soilMoistureButton.setTitle(" " + String(selectedDevice!.soilMoisture) + " %", for: .normal)
        batteryButton.setTitle(" " + String(selectedDevice!.battery) + " %", for: .normal)
        statusButton.setTitle("Status: " + String(selectedDevice!.status), for: .normal)
    }

}

extension MainScreenViewController: SelectDeviceDeelegate{
    func changeSelectedDevice(to device: Device) {
        selectedDevice = device
        refreshScreenData()
    }
}

