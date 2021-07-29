//
//  ViewController.swift
//  todo
//
//  Created by Macbook on 29/07/2021.
//

import UIKit

struct EmployeeModel {
    var fname: String
    var lname: String
}





class ViewController: UIViewController {

    @IBOutlet weak var employeeTableview: UITableView!
    var employeeArray = [EmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeTableview.register(UITableViewCell.self, forCellReuseIdentifier: "employeeCell")
        
    }


    @IBAction func plusBtnPressed(_ sender: UIBarButtonItem) {
        performAction(isEditing: false, index: 0)
        
    }
    
    func performAction(isEditing:Bool,index:Int){
        let alertController = UIAlertController(title: "Alert", message: "Add item", preferredStyle: .alert)
        alertController.addTextField { (fnameField) in
            fnameField.placeholder = "Enter the first Name"
        }
        alertController.addTextField { (lnameField) in
            lnameField.placeholder = "Enter the first Name"
        }
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            if let firstName = alertController.textFields?.first?.text{
                if let lastName = alertController.textFields?.last?.text{
                    
                    if(isEditing){
                        self.employeeArray.insert(EmployeeModel(fname: firstName, lname: lastName), at: index)
                        self.employeeArray.remove(at: index + 1 )
                    }
                    else{
                        self.employeeArray.append(EmployeeModel(fname: firstName, lname: lastName))}
                    
                    self.employeeTableview.reloadData()
                }
            }
        }
        alertController.addAction(ok)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
        
    }
    
    
    
    
    


//MARK: Tableview Datasource methods
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = " \(employeeArray[indexPath.row].fname)  \(employeeArray[indexPath.row].lname)"
        return cell
    }
    
    
    
}

//MARK: Tableview Delegate methods

 extension ViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.employeeArray.remove(at: indexPath.row)
            self.employeeTableview
                .reloadData()
        }
       
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editBtn = UITableViewRowAction(style: .normal, title: "Edit") { (_, IndexPath) in
            
            self.performAction(isEditing: true, index: indexPath.row)
        }
        editBtn.backgroundColor = .green
        let deleteBtn = UITableViewRowAction(style: .normal, title: "delete") { (_, IndexPath) in
            self.employeeArray.remove(at: indexPath.row)
            self.employeeTableview
                .reloadData()
            
        }
        deleteBtn.backgroundColor = .red
        
        UIButton.appearance().setTitleColor(.blue, for: UIControl.State.normal)

       return [editBtn,deleteBtn]
        
    }
    
    
    
}

