//
//  BudgetViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    var budget:Budget = Budget(title: "Default Title")
    var balance:Double = 0
    
    // MARK: Outlets
    @IBOutlet weak var budgetTitleLabel: UILabel!
    @IBOutlet weak var incomesTotalLabel: UILabel!
    @IBOutlet weak var expensesTotalLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var incomesTableView: UITableView!
    @IBOutlet weak var expensesTableView: UITableView!
    
    @IBOutlet weak var addExpenseButton: UIButton!
    @IBOutlet weak var addIncomeButton: UIButton!

    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTitleLabel.text = budget.title
    }
    
    override func viewDidAppear(animated: Bool) {
        update()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    // MARK: Table View Delegation
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == incomesTableView {
            return budget.incomes.count
        } else if tableView == expensesTableView {
            return budget.expenses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == incomesTableView {
            let cellIdentifier = "BudgetIncomesTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetItemTableViewCell
        
            let income = budget.incomes[indexPath.row]
        
            cell.budgetItemName.text = income.name
            cell.budgetItemAmount.text = "$" + String(income.amount)
        
            return cell
        } else {
            let cellIdentifier = "BudgetExpensesTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetItemTableViewCell
            
            let expense = budget.expenses[indexPath.row]
            
            cell.budgetItemName.text = expense.name
            cell.budgetItemAmount.text = "$" + String(expense.amount)
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            if tableView == incomesTableView {
                budget.incomes.removeAtIndex(indexPath.row)
                incomesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            if tableView == expensesTableView {
                budget.expenses.removeAtIndex(indexPath.row)
                expensesTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            update()
        }
    }
    
    // MARK: Updating View
    func updateTotals() {
        var incomesTotal:Double = 0
        var expensesTotal:Double = 0
        
        for income in (budget.incomes) {
            incomesTotal += income.amount
        }
        
        for expense in (budget.expenses) {
            expensesTotal += expense.amount
        }
        
        balance = incomesTotal - expensesTotal
        
        incomesTotalLabel.text = "$" + String(incomesTotal)
        expensesTotalLabel.text = "$" + String(expensesTotal)
        balanceLabel.text = "$" + String(balance)
        
    }
    
    func updateTableViews() {
        incomesTableView.reloadData()
        expensesTableView.reloadData()
    }
    
    func update() {
        updateTableViews()
        updateTotals()
    }
    
    
    // MARK: Navigation
    // Action receives data from the AddNewBudgetItemController and adds the new item to the array and table
    @IBAction func unwindToBudget(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? AddBudgetItemViewController, budgetItem = sourceViewController.budgetItem, tableName = sourceViewController.tableName {
            
            if tableName == "expense" {
                let newIndexPath = NSIndexPath(forRow: budget.expenses.count, inSection: 0)
                budget.expenses.append(budgetItem)
                expensesTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            if tableName == "income" {
                let newIndexPath = NSIndexPath(forRow: budget.incomes.count, inSection: 0)
                budget.incomes.append(budgetItem)
                incomesTableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Segue to AddNewBudgetItemController for adding new items
        if let navVC = segue.destinationViewController as? UINavigationController {
            
            if let destVC = navVC.viewControllers.first as? AddBudgetItemViewController {
                
                if addExpenseButton === sender {
                    destVC.tableName = "expense"
                }
                if addIncomeButton === sender {
                    destVC.tableName = "income"
                }
            }
        }
        
        // Segue to Pie Chart
        if let destVC = segue.destinationViewController as? PieChartViewController {
            destVC.budget = budget
            destVC.balance = balance
        }
    }
    
}
