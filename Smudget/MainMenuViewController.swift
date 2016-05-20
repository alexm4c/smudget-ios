//
//  MainMenu.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    var newBudgetTitle:String?
    
    // When new button is clicked show a AlertController
    // to prompt the user for the new budgets title
    // With that, begin the segue to BudgetVC
    @IBAction func newBudget_Clicked(sender: UIButton) {
        let alert = UIAlertController(title: "New Budget", message: "Enter new budget title", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Go", style: .Default, handler: {
            [unowned self, alert] (action: UIAlertAction!) in
            self.newBudgetTitle = alert.textFields![0].text
            self.performSegueWithIdentifier("newBudgetSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {
            (action: UIAlertAction) -> Void in
        }))
        alert.addTextFieldWithConfigurationHandler({
            (textField: UITextField!) in
            textField.placeholder = "Enter Title Here"
        })
        self.presentViewController(alert, animated: true, completion: nil)
        self.view.endEditing(true)
    }
    
    // MARK: Navigation
    // Navigate to BudgetViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let navVC = segue.destinationViewController as? UINavigationController {
            if let destVC = navVC.viewControllers.first as? BudgetViewController {
                if segue.identifier == "newBudgetSegue" {
                    let newBudget = Budget()
                    newBudget.title = newBudgetTitle!
                    newBudget.id = BudgetModelManager.nextID()
                    BudgetModelManager.sharedInstance.budgets.append(newBudget)
                    // We just appended the new budget to the last index
                    // So we can just pass that to the budget view
                    destVC.budget = BudgetModelManager.sharedInstance.budgets.last!
                }
            }
        }
    }
    // Navigation to Existing requires no logic
    // and is done through a storyboard segue
    
}