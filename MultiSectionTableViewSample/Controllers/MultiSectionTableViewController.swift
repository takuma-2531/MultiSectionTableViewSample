//
//  MultiSectionTableViewController.swift
//  MultiSectionTableViewSample
//
//  Created by 小川卓馬 on 2021/05/09.
//

import UIKit

final class MultiSectionTableViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var addTextField: UITextField!
    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak private var pickerView: UIPickerView!
    
    private var items = Items()
    private var pickerRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        addButtonIsEnabled()
        
        addButton.isEnabled = false

    }
    
    @IBAction func addTextFieldEditing(_ sender: UITextField) {
        addButtonIsEnabled()
    }
    
    @IBAction func tapAddSection(_ sender: UIBarButtonItem) {
        showAlert()
        items.twoDimArray.append([])
        reloadView()
    }
    
    @IBAction func tapAddButton(_ sender: UIButton) {
        items.twoDimArray[pickerRow].append(addTextField.text!)
        addTextField.text = ""
        addButtonIsEnabled()
        reloadView()
    }
    

}
// MARK: - function
extension MultiSectionTableViewController {
    func reloadView() {
        tableView.reloadData()
        pickerView.reloadAllComponents()
    }
    
    // 命名法検討
    func addButtonIsEnabled() {
        if 0 < addTextField.text!.count &&
            0 < items.mySections.count {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }
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

// MARK: - UITableViewDataSource
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
// MARK: - UITableViewDelegate
extension MultiSectionTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionName = items.mySections[indexPath.section]
        let cellName = items.twoDimArray[indexPath.section][indexPath.row]
        
        print(sectionName + "の" + cellName + "さん")
    }
    
}
// MARK: - UIPickerViewDataSource
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
// MARK: - UIPickerViewDelegate
extension MultiSectionTableViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items.mySections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRow = row
    }
    
    
}



