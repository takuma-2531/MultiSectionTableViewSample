//
//  MultiSectionTableViewController.swift
//  MultiSectionTableViewSample
//
//  Created by 小川卓馬 on 2021/05/09.
//

import UIKit

class MultiSectionTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mySections = [String]()
    var twoDimArray = [[String]]()
    var selectedClass = ""
    var selectedPerson = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        mySections = ["A", "B", "C"]
        
        for _ in 0...mySections.count {
            twoDimArray.append([])
        }
        
        twoDimArray[0] = ["あ", "い", "う"]
        twoDimArray[1] = ["え", "お"]
        twoDimArray[2] = ["か", "き", "く"]
        
        
    }

}

extension MultiSectionTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        mySections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.nameLabel.text = twoDimArray[indexPath.section][indexPath.row]
        return cell
    }
    
    
}

extension MultiSectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            selectedClass = mySections[indexPath.section]
            selectedPerson = twoDimArray[indexPath.section][indexPath.row]
            
            print(selectedClass + "の" + selectedPerson + "さん")
        }
        
}



