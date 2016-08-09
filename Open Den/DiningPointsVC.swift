//
//  DiningPointsVC.swift
//  Hungry Cougar 2.0
//
//  Created by Kyle Nakamura on 8/9/16.
//  Copyright © 2016 Kyle Nakamura. All rights reserved.
//

import UIKit

// Global variables
var diningPlanChoice = ""

class DiningPointsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var diningPlanImages: [UIImage] = [#imageLiteral(resourceName: "money5"), #imageLiteral(resourceName: "money4"), #imageLiteral(resourceName: "money3"), #imageLiteral(resourceName: "money2"), #imageLiteral(resourceName: "money1")]
    var diningTitles: [String] = ["No Worries", "We've Got You Covered", "Weekend Away", "Forgot To Cook", "Grab And Go"]
    
    var img: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = diningTitles[indexPath.row]
        diningPlanChoice = message
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DiningPlans") as? DiningPlanCell {
            img = diningPlanImages[indexPath.row]
            cell.configureCell(image: img, text: diningTitles[indexPath.row])
            return cell
        } else {
            return DiningPlanCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    @IBAction func onDiningButtonPressed() {
        
    }
    
}
