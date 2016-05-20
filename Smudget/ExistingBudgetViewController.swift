//
//  ExistingBudgetViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class ExistingBudgetViewController: UITableViewController {
        
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
        return BudgetModelManager.sharedInstance.budgets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "BudgetTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetTableViewCell
        
        let budget = BudgetModelManager.sharedInstance.budgets[indexPath.row]
        
        cell.budgetTitleLabel.text = budget.title
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            BudgetModelManager.sharedInstance.budgets.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.reloadData()
        }
        
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navVC = segue.destinationViewController as? UINavigationController {
        
            if let destVC = navVC.viewControllers.first as? BudgetViewController {
            
                if segue.identifier == "existingToBudgetSegue" {
                    if let budgetIndex = tableView.indexPathForSelectedRow?.row {
                        destVC.budget = BudgetModelManager.sharedInstance.budgets[budgetIndex]
                    }
                }
            }
        }
    }
    
}