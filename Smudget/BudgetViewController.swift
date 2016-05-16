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
    var budget:Budget = Budget()
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

    // MARK: Actions
    @IBAction func addIncome_Clicked(sender: UIButton) {
        promptForNewBudgetItem("income", addItem: {
            (item: Budget.BudgetItem) in
            self.budget.incomes.append(item)
            self.update()
        })
    }
    @IBAction func addExpense_Clicked(sender: UIButton) {
        promptForNewBudgetItem("expense", addItem: {
            (item: Budget.BudgetItem) in
            self.budget.incomes.append(item)
            self.update()
        })
    }
    
    func promptForNewBudgetItem(budgetItemName:String, addItem: (item: Budget.BudgetItem) -> Void) {
        let alertTitle = "New " + budgetItemName
        let alertMessage = "Enter " + budgetItemName + " details"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Go", style: .Default, handler: {
            (action: UIAlertAction!) in
            let newItemName:String = alert.textFields![0].text ?? ""
            let newItemValue:Double = Double(alert.textFields![1].text!) ?? 0
            let newBudgetItem = Budget.BudgetItem(name: newItemName, value: newItemValue)
            addItem(item: newBudgetItem)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {
            (action: UIAlertAction) -> Void in
        }))
        alert.addTextFieldWithConfigurationHandler({
            (textField: UITextField!) in
            textField.placeholder = "Enter Name"
        })
        alert.addTextFieldWithConfigurationHandler({
            (textField: UITextField!) in
            textField.placeholder = "Enter Value ($$)"
        })
        self.presentViewController(alert, animated: true, completion: nil)
        self.view.endEditing(true)
    
    }
    
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
            cell.budgetItemAmount.text = "$" + String(income.value)
        
            return cell
        } else {
            let cellIdentifier = "BudgetExpensesTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetItemTableViewCell
            
            let expense = budget.expenses[indexPath.row]
            
            cell.budgetItemName.text = expense.name
            cell.budgetItemAmount.text = "$" + String(expense.value)
            
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
            incomesTotal += income.value
        }
        
        for expense in (budget.expenses) {
            expensesTotal += expense.value
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Segue to Pie Chart
        if let destVC = segue.destinationViewController as? PieChartViewController {
            destVC.budget = budget
            destVC.balance = balance
        }
    }
    
}
