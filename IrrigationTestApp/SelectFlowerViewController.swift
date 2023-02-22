//
//  SelectFlowerViewController.swift
//  IrrigationTestApp
//
//  Created by Maria Nosova on 8/15/22.
//  Copyright © 2022 Andrey Nosov. All rights reserved.
//

import UIKit

/* //delete
struct Flower: Decodable, Encodable{
    let names: [String]
    let soilMoistureBorders: (Double, Double)
    let temperatureBorders: (Int, Int)
    let lightLevelBorders: (Int, Int)
    
    func identify(with identifier: String) -> Bool{
        var result:Bool = false
        for name in names{
            if name.range(of: identifier, options: .caseInsensitive) != nil{
                result = true
            }
        }
        return result
    }
}
*/

struct Plant: Decodable, Encodable{
    let names: [String]
    let minSoilMoisture: Int
    let maxSoilMoisture: Int
    let minTemperature: Int
    let maxTemperature: Int
    let minLight: Int
    let maxLight: Int
    
    func identify(with identifier: String) -> Bool{
        var result:Bool = false
        for name in names{
            if name.range(of: identifier, options: .caseInsensitive) != nil{
                result = true
            }
        }
        return result
    }
    
}

var flowersNames: [[String]] = [["Rose", "Rosa"],["Lily", "Lilium"],["Tulip","Tulipa"],["Orchid","Phalaenopsis"],["Carnation", "Dianthus"],["Freesia"], ["Hyacinth", "Alstroemeria"], ["Peruvian Lily", "Alstroemeria"], ["Chrysanthemum"], ["Gladiolus"], ["Anemone"], ["Daffodil", "Narcissus", "Jonquil"], ["Poppy", "Papaver"], ["Sunflower", "Helianthus"]]


//var filteredFlowers: [Flower] = [] //delete
//var selectedFlowerIndex: Int?

var filteredPlants: [Plant] = []


class SelectFlowerViewController: UIViewController {

    @IBOutlet weak var flowerSearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        if flowerSearchBar.text!.isEmpty{
            filteredPlants = plants
        }
        else{
            filteredPlants = []
            for plant in plants{
                if plant.identify(with: flowerSearchBar.text!) {
                    filteredPlants.append(plant)
                }
            }
        }
    }
    override func viewDidLoad() {

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }


}

extension SelectFlowerViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlowerCell") as! FlowerTableViewCell
        cell.FlowerCellLabel.text = filteredPlants[indexPath.row].names[0]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return filteredPlants.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //selectedFlowerIndex = indexPath.row //delete
        if let vc = storyboard?.instantiateViewController(identifier: "FlowerInfoViewController") as? FlowerInfoViewController {
           vc.plantToShow = filteredPlants[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension SelectFlowerViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        if searchText.isEmpty != true{
           filteredPlants = []
            for plant in plants{
                if plant.identify(with: searchText) {
                    filteredPlants.append(plant)
                }
            }
        }
        else{
            filteredPlants = plants
        }
        TableView.reloadData()
    }
}

class FlowerTableViewCell: UITableViewCell {
    @IBOutlet weak var FlowerCellLabel: UILabel!
    
}

public extension Double {
    static var random: Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
static func random(min: Double, max: Double) -> Double {
    return Double.random * (max - min) + min
}
    
}

class FlowerInfoViewController: UIViewController{
    @IBOutlet weak var flowerNameLabel: UILabel!
    @IBOutlet weak var flowerOtherNamesLabel: UILabel!
    @IBOutlet weak var soilMoistureLevelLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var lightLevelLabel: UILabel!
    
    var plantToShow: Plant?
    
    @IBAction func addNewDevice(_ sender: Any) {
        if devicesAvailable() == false{
            devices[0] = Device(id: (devices.last?.id ?? 0) + 1, plants: [plantToShow!], soilMoisture: Int(Double.random(min: 10, max: 90)), temperature: Int(Double.random(min: 17, max: 32)), light: Int(Double.random(min: 1000, max: 20000)), battery: Int(Double.random(min: 1, max: 100)), status: "Good")
        }
        else{
        devices.append(Device(id: (devices.last?.id ?? 0) + 1, plants: [plantToShow!], soilMoisture: Int(Double.random(min: 10, max: 90)), temperature: Int(Double.random(min: 17, max: 32)), light: Int(Double.random(min: 1000, max: 20000)), battery: Int(Double.random(min: 1, max: 100)), status: "Good"))
        }
        saveDevices(devices)
        performSegue(withIdentifier: "unwindToMain3", sender: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flowerNameLabel.text = plantToShow!.names[0]
        if plantToShow!.names.count > 1{
        for (index, name) in plantToShow!.names.enumerated(){
            if index == 0 {continue}
            if index == 1 { flowerOtherNamesLabel.text = name; continue}
            flowerOtherNamesLabel.text = flowerOtherNamesLabel.text! + ", \(name)"
        }
        }
        else{
            flowerOtherNamesLabel.isHidden = true
        }
        soilMoistureLevelLabel.text = String(plantToShow!.minSoilMoisture) + " - " + String(plantToShow!.maxSoilMoisture) + " %"
        temperatureLabel.text = String(plantToShow!.minTemperature ) + " - " +  String(plantToShow!.maxTemperature)+"°"
        lightLevelLabel.text = String(plantToShow!.minLight) + " - " + String(plantToShow!.maxLight) + " lx"
    }
}
