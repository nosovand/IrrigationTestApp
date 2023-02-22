//
//  ViewController.swift
//  IrrigationTestApp
//
//  Created by Maria Nosova on 8/15/22.
//  Copyright © 2022 Andrey Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func cancelAddingDevice(_ sender: Any) {
        if devicesAvailable(){
            performSegue(withIdentifier: "unwindToMain2", sender: self)
        }
        else{
            performSegue(withIdentifier: "returnToAddScreen", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


