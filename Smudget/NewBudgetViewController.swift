//
//  NewBudgetController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class NewBudgetViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var budgetTitleTextField: UITextField!
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTitleTextField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Text Field Delegation
    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navVC = segue.destinationViewController as? UINavigationController {
            
            if let destVC = navVC.viewControllers.first as? BudgetViewController {
                
                if segue.identifier == "newToBudgetSegue" {
                    let newBudget = Budget()
                    newBudget.title = budgetTitleTextField.text!
                    BudgetModelManager.sharedInstance.budgets.append(newBudget)
                    // We just appended the new budget to the last index
                    // So we can just pass that to the budget view
                    destVC.budget = BudgetModelManager.sharedInstance.budgets.last!
                }
            }
        }
    }
    
}