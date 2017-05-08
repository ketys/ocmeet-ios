//
//  CarListViewController.swift
//  OCmeet
//
//  Created by Jirka Ketner on 20/04/17.
//  Copyright © 2017 Jirka Ketner. All rights reserved.
//

import UIKit
import Alamofire

class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var thumb: UIImageView!
}

class CarListViewController: UITableViewController {
    
    var cars = [Car]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
        
    }
    
    func loadCars() {
        OCmeetAPIManager.sharedInstance.fetchCars() { result in
            guard result.error == nil else {
                self.handleLoadCarsError(result.error!)
                return
            }
            
            if let fetchedCars = result.value {
                self.cars = fetchedCars
            }
            
            self.tableView.reloadData()
        }
    }
    
    func handleLoadCarsError(_ error: Error) {
        // TODO
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorColor = UIColor.init(red: 51/255, green: 164/255, blue: 52/255, alpha: 1)
        
        //OCmeetAPIManager.sharedInstance.printCars()
        
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
            
            print(car.toString())
            print(car.number)
        }
         */

        
        /*
        Alamofire.request(OCmeetRouter.getCars())
            .responseJSON { response in
                //check for errors
                guard response.result.error == nil else {
                    print("error calling GET on /api/cars")
                    print(response.result.error!)
                    return
                }
                
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get cars as JSON object from API")
                    print("Error: \(response.result.error)")
                    return
                }
                print(json)
            }
        */

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarTableViewCell
        let car = cars[indexPath.row]
        cell.number?.text = "#" + String(car.number)
        cell.owner?.text = car.owner
        cell.category?.text = car.category
        
        cell.thumb?.image = nil
        OCmeetAPIManager.sharedInstance.imageFrom(urlString: car.thumbnailURL) { (image, error) in
            guard error == nil else {
                print(error!)
                return
            }
            if let cellToUpdate = self.tableView?.cellForRow(at: indexPath) as? CarTableViewCell {
                cellToUpdate.thumb?.image = image
                cellToUpdate.thumb?.layer.cornerRadius = 35
                cellToUpdate.thumb?.layer.masksToBounds = true
                cellToUpdate.setNeedsLayout()
            }
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
