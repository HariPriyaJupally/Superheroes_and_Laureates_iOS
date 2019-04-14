//
//  LaureatesTableViewController.swift
//  Superheroes_and_Laureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Laureates.shared.fetchLaureatesFromURL()
        NotificationCenter.default.addObserver(self, selector:#selector(laureatesDataDelivered),name: NSNotification.Name("Laureates data delivered"), object:nil)
    }
    
    @objc func laureatesDataDelivered(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Laureates.shared.laureates.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureates", for: indexPath)
        let myLaureate = Laureates.shared.laureates[indexPath.row]
        let nameLBL = cell.viewWithTag(400) as! UILabel
        let dobLBL = cell.viewWithTag(500) as! UILabel
        nameLBL.text = "\(myLaureate.firstname!) \(myLaureate.surname!)"
        dobLBL.text = "\(myLaureate.born!) - \(myLaureate.died!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LAUREATES"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
}
