//
//  CarViewController.swift
//  OCmeet
//
//  Created by Jirka Ketner on 03/05/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        /*
        Car.getById(id: 1) { result in
            if let error = result.error {
                print("error calling GET on /cars/{id}")
                print(error)
                return
            }
            
            guard let car = result.value else {
                print("error calling GET on /cars/{id} – result is nil")
                return
            }
            
            //print(car.toString())
            print(car.number)
        }
    	*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

