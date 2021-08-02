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
    var age: Int
}
enum EmployeeCrud {
    case delete
    case edit
    case add
}




class ViewController: UIViewController {

    @IBOutlet weak var employeeTableview: UITableView!
    var employeeArray = [EmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func plusBtnPressed(_ sender: UIBarButtonItem) {
        performAction(employeeCrud: .add)
        
    }
    
    }
    
    
    
    
    


//MARK: Tableview Datasource methods
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let ages:[Int] = [30,31,32,33,34,35,35,37,38,39,40,41,42,43,44,45]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell")
        else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = " \(employeeArray[indexPath.row].fname)  \(employeeArray[indexPath.row].lname)"
        cell.detailTextLabel?.text = "Age:   \(employeeArray[indexPath.row].age)"
        return cell
    }
}

//MARK: Tableview Delegate methods

 extension ViewController: UITableViewDelegate{
   
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { (_, _, _) in
            self.performAction(employeeCrud: .delete, index: indexPath.row)
        }
        let edit = UIContextualAction(style: .normal, title: "edit") { (_, _, _) in
            self.performAction(employeeCrud: .edit, index: indexPath.row)
        }
        let actions = UISwipeActionsConfiguration(actions: [delete, edit])
        return actions
    }
    
    
}

// MARK: Function
extension ViewController{
    func performAction(employeeCrud:EmployeeCrud,index:Int = 0)  {
        switch employeeCrud {
        case .delete:
            self.employeeArray.remove(at: index)
            self.employeeTableview.reloadData()
        default:
            let alertController = UIAlertController(title: "Welcome to ", message: "Add or Edit", preferredStyle: .alert)
            alertController.addTextField { (fnameField) in
                if(employeeCrud == .edit){
                    fnameField.text = "\(self.employeeArray[index].fname)"
                }else{
                    fnameField.placeholder = "Enter the first Name"}
            
            alertController.addTextField { (lnameField) in
                if(employeeCrud == .edit){
                    lnameField.text = "\(self.employeeArray[index].lname)"
                }else{
                    lnameField.placeholder = "Enter last name"}

            
            let ok = UIAlertAction(title: "OK", style: .default) { (_) in
                if let firstName = alertController.textFields?.first?.text{
                    if let lastName = alertController.textFields?.last?.text{
                        
                        if(employeeCrud == .edit){
                            self.employeeArray[index] = EmployeeModel(fname: firstName, lname: lastName, age: self.employeeArray[index].age)
                        }
                        if(employeeCrud == .add){
                            self.employeeArray.append(EmployeeModel(fname: firstName, lname: lastName, age: Int.random(in: 30..<50)))}
                    
                        self.employeeTableview.reloadData()}}}
                    alertController.addAction(ok)
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
        }
    }
    
    
    
    /*
    
    func  performAction(isEditing:Bool,index:Int,forDelete:Bool){
        if(isEditing || !forDelete){
            
            let alertController = UIAlertController(title: "Welcome to ", message: "Add or Edit", preferredStyle: .alert)
            alertController.addTextField { (fnameField) in
                if(isEditing){
                    fnameField.text = "\(self.employeeArray[index].fname)"
                }else{
                    fnameField.placeholder = "Enter the first Name"}
            }
            alertController.addTextField { (lnameField) in
                if(isEditing){
                    lnameField.text = "\(self.employeeArray[index].lname)"
                }else{
                    lnameField.placeholder = "Enter last name"}

            }
            let ok = UIAlertAction(title: "OK", style: .default) { (_) in
                if let firstName = alertController.textFields?.first?.text{
                    if let lastName = alertController.textFields?.last?.text{
                        
                        if(isEditing && !forDelete){
                            self.employeeArray[index] = EmployeeModel(fname: firstName, lname: lastName, age: self.employeeArray[index].age)
                        }
                         if(!isEditing && !forDelete){
                            self.employeeArray.append(EmployeeModel(fname: firstName, lname: lastName, age: Int.random(in: 30..<50)))}
                    
                        self.employeeTableview.reloadData()}}}
                    alertController.addAction(ok)
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
        else{
            self.employeeArray.remove(at: index)
            self.employeeTableview.reloadData()
        }
        
        
    }
 */
    }}
