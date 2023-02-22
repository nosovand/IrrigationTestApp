//
//  DeviceSettingsViewController.swift
//  IrrigationTestApp
//
//  Created by Maria Nosova on 8/23/22.
//  Copyright © 2022 Andrey Nosov. All rights reserved.
//

import UIKit

class DeviceSettingsViewController: UIViewController {

    var selectedDevice: Device?
    
    @IBAction func deleteDeviceButton(_ sender: Any) {
        for (index, device) in devices.enumerated() {
            if selectedDevice!.id == device.id{
                devices.remove(at: index)
                break
            }
        }
        saveDevices(devices)
        print("test")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
