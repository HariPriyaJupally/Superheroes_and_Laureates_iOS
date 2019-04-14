//
//  SuperherosTableViewController.swift
//  Superheroes_and_Laureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit

class SuperherosTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Superheroes.shared.fetchSuperheroesFromURL()
        NotificationCenter.default.addObserver(self, selector:#selector(superHeroesDelivered),name: NSNotification.Name("Superheroes data delivered"), object:nil)
    }
    
    @objc func superHeroesDelivered(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Superheroes.shared.superMembers.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheros", for: indexPath)
        let mySuperhero = Superheroes.shared.superMembers[indexPath.row]
        cell.textLabel?.text = "\(mySuperhero.name) (aka: \(mySuperhero.secretIdentity))"
        var powersText = ""
        for i in 0..<mySuperhero.powers.count{
            if i == mySuperhero.powers.count - 1  {
                powersText += mySuperhero.powers[i]
            }else{
                powersText += "\(mySuperhero.powers[i]), "
            }
        }
        cell.detailTextLabel?.text = powersText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUPERHEROS"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 180
    }

    
}

