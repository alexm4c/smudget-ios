//
//  PieChartViewController.swift
//  Smudget
//
//  Created by Alex Mc Bain on 4/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import UIKit
import Charts

class PieChartViewController: UIViewController {
    
    // MARK: Properties
    var budget:Budget = Budget()

    // Calculation for balance has already been made in the 
    // budget view controller so why not just pass it in
    var balance:Double = 0
    
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var chartTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Interface stuff
        pieChartView.descriptionText = "Incomes are red and, expenses are blue, I made a pie chart, just for you"
        
        chartTitleLabel.text = budget.title
        
        // Set up chart data
        var dataNames = [String]()
        var dataValues = [Double]()
        
        // Income data
        for income in budget.incomes {
            dataNames.append(income.name)
            dataValues.append(income.value)
        }
        
        // Expense data
        for expense in budget.expenses {
            dataNames.append(expense.name)
            dataValues.append(expense.value)
        }
        
        // Balance
        dataNames.append("Balance")
        dataValues.append(balance)
        
        setChart(dataNames, values: dataValues)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(yVals: dataEntries, label:"")
        let pieChartData = PieChartData(xVals: dataPoints, dataSet: pieChartDataSet)
        
        pieChartView.data = pieChartData
        
        var colours: [UIColor] = []
        
        let totalItems = budget.expenses.count + budget.incomes.count
        
        // Incomes colours
        // Colours decrease in brightness as more items are added. Note that at some point this will break when too many items are present
        for i in 0..<budget.incomes.count {
            let red = Double(255)
            let green = Double(179 - (i * 26))
            let blue = Double(179 - (i * 26))
            
            let colour = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            
            colours.append(colour)
        }
        
        // Expenses colours
        // Same story as the Incomes colours
        for i in budget.incomes.count..<totalItems {
            let red = Double(179 - (i * 26))
            let green = Double(179 - (i * 26))
            let blue = Double(255)
            
            let colour = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            
            colours.append(colour)
        }
        
        // Balance colour
        colours.append(UIColor(red: CGFloat(Double(0)/255), green: CGFloat(Double(204)/255), blue: CGFloat(Double(102)/255), alpha: 1))
        
        pieChartDataSet.colors = colours
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}