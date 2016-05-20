//
//  BudgetViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 5/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//



import UIKit

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Properties
    var budget:Budget = Budget()
    var balance:Double = 0
    let currencyModel = CurrencyModel()
    var currencyBase = "AUD"
    
    // MARK: Outlets
    @IBOutlet weak var budgetTitleLabel: UILabel!
    @IBOutlet weak var incomesTotalLabel: UILabel!
    @IBOutlet weak var expensesTotalLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var incomesTableView: UITableView!
    @IBOutlet weak var expensesTableView: UITableView!
    
    @IBOutlet weak var addExpenseButton: UIButton!
    @IBOutlet weak var addIncomeButton: UIButton!

    @IBOutlet weak var currencySelector: UITextField!
    
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
            self.budget.expenses.append(item)
            self.update()
        })
    }
    
    // Function called when the add buttons are pressed, displays an alertview for inputing new item details
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
        
        // Set up picker view for changing currency
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        if let defaultRowIndex = currencyModel.currencyList.indexOf(budget.currency) {
            pickerView.selectRow(defaultRowIndex, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }

        let toolbar = UIToolbar()
        toolbar.barStyle = .Default
        toolbar.translucent = true
        toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "donePicker")
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.userInteractionEnabled = true
        
        currencySelector.text = budget.currency
        currencySelector.borderStyle = .None
        currencySelector.inputView = pickerView
        currencySelector.inputAccessoryView = toolbar
    }
    
    override func viewDidAppear(animated: Bool) {
        update()
    }
    
    // MARK: Picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
 
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyModel.currencyList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyModel.currencyList[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let newCurrencyBase = currencyModel.currencyList[row]
        currencyModel.getRateFromAPI(currencyBase, forCurrency: newCurrencyBase, onResponse: changeBudgetCurrencyBase)
        currencyBase = currencyModel.currencyList[row]
        currencySelector.text = newCurrencyBase
        budget.currency = newCurrencyBase
    }
    
    func changeBudgetCurrencyBase(rate:Double?) {
        if rate != nil {
            for i in 0..<budget.expenses.count {
                budget.expenses[i].value *= rate!
            }
            for i in 0..<budget.incomes.count {
                budget.incomes[i].value *= rate!
            }
            update()
        }
    }
    
    func donePicker() {
        currencySelector.resignFirstResponder()
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
            cell.budgetItemAmount.text = String(format: "%.2f", income.value)
        
            return cell
        } else {
            let cellIdentifier = "BudgetExpensesTableViewCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BudgetItemTableViewCell
            
            let expense = budget.expenses[indexPath.row]
            
            cell.budgetItemName.text = expense.name
            cell.budgetItemAmount.text = String(format: "%.2f", expense.value)
            
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
    func update() {
        
        // update TableViews
        incomesTableView.reloadData()
        expensesTableView.reloadData()
        
        // update Totals
        balance = budget.balanceTotal()
        incomesTotalLabel.text = String(format: "%.2f", budget.incomeTotal())
        expensesTotalLabel.text = String(format: "%.2f", budget.expenseTotal())
        balanceLabel.text = String(format: "%.2f", balance)
        
        // Each time something is changed and the budget
        // view needs to be updated also save data
        BudgetModelManager.sharedInstance.saveBudgets()
    
    }
    
    // MARK: Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // Segue to Pie Chart
        if let destinationVC = segue.destinationViewController as? PieChartViewController {
            destinationVC.budget = budget
            destinationVC.balance = balance
        }
        
    }
    
}
