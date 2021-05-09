//
//  MultiSectionTableViewController.swift
//  MultiSectionTableViewSample
//
//  Created by 小川卓馬 on 2021/05/09.
//

import UIKit

class MultiSectionTableViewController: UIViewController {
    
    var a = ["a", "b", "c", "d"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var items = Items()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if items.mySections.count == 0 {
            addButton.isEnabled = false
        }

    }
    
    @IBAction func tapAddSection(_ sender: UIBarButtonItem) {
        
        showAlert()
        items.twoDimArray.append([])
        
        if 0 < items.mySections.count {
            addButton.isEnabled = true
        }
        
        reloadView()
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        items.twoDimArray[items.mySections.count - 1].append(addTextField.text!)
        addTextField.text = ""
        reloadView()
    }
    
    func reloadView() {
        tableView.reloadData()
        pickerView.reloadAllComponents()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Section追加", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.clearButtonMode = UITextField.ViewMode.whileEditing
            textField.placeholder = "Section名入力"
        }
        
        let action = UIAlertAction(title: "OK", style: .default) { alertAction in
            if let text = alert.textFields![0].text {
                if text.count != 0 {
                    self.addSection(sectionName: text)
                    self.reloadView()
                }
            }
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func addSection(sectionName: String) {
        items.mySections.append(sectionName)
    }

}

extension MultiSectionTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.mySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.twoDimArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items.mySections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.nameLabel.text = items.twoDimArray[indexPath.section][indexPath.row]
        return cell
    }
    
    
}

extension MultiSectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionName = items.mySections[indexPath.section]
        let cellName = items.twoDimArray[indexPath.section][indexPath.row]
        
        print(sectionName + "の" + cellName + "さん")
    }
    
}

extension MultiSectionTableViewController: UIPickerViewDataSource {
    // 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.mySections.count
    }
    
}

extension MultiSectionTableViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items.mySections[row]
    }
}



