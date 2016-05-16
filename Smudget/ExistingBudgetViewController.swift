//
//  ExistingBudgetViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class ExistingBudgetViewController: UITableViewController {
    
    // MARK: Properties
    let budgets = BudgetModelManager.sharedInstance.budgets
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Table View Delegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return budgets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BudgetTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetTableViewCell
        
        let budget = budgets[indexPath.row]
        
        cell.budgetTitleLabel.text = budget.title
        
        return cell
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navVC = segue.destinationViewController as? UINavigationController {
        
            if let destVC = navVC.viewControllers.first as? BudgetViewController {
            
                if segue.identifier == "existingToBudgetSegue" {
                    if let budgetIndex = tableView.indexPathForSelectedRow?.row {
                        destVC.budget = budgets[budgetIndex]
                    }
                }
            }
        }
    }
    
}