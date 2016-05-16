//
//  AddBudgetItemViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 6/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class AddBudgetItemViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    
    var budgetItem: Budget.BudgetItem?
    var tableName:String? = "nothing"
    
    @IBOutlet weak var addToTableLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    // MARK: Actions
    
    @IBAction func cancle(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        amountTextField.delegate = self
        
        // Put the name of the budget item (income or expense)
        // in the top label to remind the user what they're adding
        let tableString = tableName!.capitalizedString ?? ""
        addToTableLabel.text?.appendContentsOf(tableString)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text Field
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if doneButton === sender {
            
            let name = nameTextField.text ?? ""
            let value = Double(amountTextField.text!) ?? 0
            let newBudgetItem = Budget.BudgetItem(name: name, value: value)
            budgetItem = newBudgetItem
        }
    }
    
}