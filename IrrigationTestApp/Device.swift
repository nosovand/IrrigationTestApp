//
//  Device.swift
//  
//
//  Created by Maria Nosova on 8/19/22.
//

import Foundation

class Device: Decodable, Encodable{
    let id: Int
    var plants: [Plant]
    var soilMoisture: Int
    var temperature: Int
    var light: Int
    var battery: Int
    var status: String
    
    init(id: Int, plants: [Plant], soilMoisture: Int, temperature: Int, light: Int, battery: Int, status: String) {
        self.id = id
        self.plants = plants
        self.soilMoisture = soilMoisture
        self.temperature = temperature
        self.light = light
        self.battery = battery
        self.status = status
    }
}

var _devices: [Device]{
    get{
    let defaultDevice = Device(id: 0, plants: [Plant(names: ["default"], minSoilMoisture: 0, maxSoilMoisture: 0, minTemperature: 0, maxTemperature: 0, minLight: 0, maxLight: 0)], soilMoisture: 0, temperature: 0, light: 0, battery: 0, status: "default")
    if let objects = UserDefaults.standard.value(forKey: "saved_devices") as? Data {
       let decoder = JSONDecoder()
        if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Device], objectsDecoded.isEmpty == false {
          return objectsDecoded
        
       } else {
          return [defaultDevice]
       }
    } else {
       return [defaultDevice]
    }
    }
}

func saveDevices(_ allObjects: [Device]) {
     let encoder = JSONEncoder()
     if let encoded = try? encoder.encode(allObjects){
        UserDefaults.standard.set(encoded, forKey: "saved_devices")
     }
    devices = _devices
}

var devices: [Device] = _devices

func devicesAvailable()->Bool{
    //devices = _devices
    if devices[0].status == "default"{
        return false
    }
    else{
        return true
    }
}
