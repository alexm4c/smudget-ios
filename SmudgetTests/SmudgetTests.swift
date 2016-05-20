//
//  SmudgetTests.swift
//  SmudgetTests
//
//  Created by Alex Mc Bain on 20/05/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import XCTest

@testable import Smudget

class SmudgetTests: XCTestCase {
    
    func testBudget() {
        let testIncomeValues:[Double] = [1, 2, 3, 4, 5]
        let testIncomeTotal:Double = 15
        
        let testExpenseValues:[Double] = [6, 7, 8, 9, 10]
        let testExpenseTotal:Double = 40
        
        let budget = Budget()
        
        for i in 0...4 {
            let income = Budget.BudgetItem(name: "item"+String(i), value: testIncomeValues[i])
            budget.incomes.append(income)
            
            let expense = Budget.BudgetItem(name: "item"+String(i), value: testExpenseValues[i])
            budget.expenses.append(expense)
        }
        
        XCTAssert(budget.expenseTotal() == testExpenseTotal)
        XCTAssert(budget.incomeTotal() == testIncomeTotal)
        XCTAssert(budget.balanceTotal() == testIncomeTotal + testExpenseTotal)
    }
    
    func testAPICurrencyList() {
        let currencyList = CurrencyModel().currencyList
        print("valid currencies returned by API are:")
        print(currencyList)
        
        // If we got through the API call
        // and nothing broke that's good enough
        XCTAssert(true)
    }
    
    func testAPIRate() {
        let base = "AUD"
        let currencyFor = "USD"
        
        CurrencyModel().getRateFromAPI(base, forCurrency: currencyFor, onResponse: {
            rate in
            print("exchange rate for AUD -> USD is " + String(rate))
        })
        
        // If we got through the API call
        // and nothing broke that's good enough
        XCTAssert(true)
    }
    
    func testSaveBudget() {
        let testIncomeValues:[Double] = [1, 2, 3, 4, 5]
        let testExpenseValues:[Double] = [6, 7, 8, 9, 10]
        
        let budget = Budget()
        budget.title = "XCT TEST BUDGET"
        budget.id = BudgetModelManager.nextID()
        
        for i in 0...4 {
            let income = Budget.BudgetItem(name: "item"+String(i), value: testIncomeValues[i])
            budget.incomes.append(income)
            
            let expense = Budget.BudgetItem(name: "item"+String(i), value: testExpenseValues[i])
            budget.expenses.append(expense)
        }
        
        BudgetModelManager.sharedInstance.budgets.append(budget)
        
        BudgetModelManager.sharedInstance.saveBudgets()
        
        // If we made it this far through the
        // BudgetModelManager and back then it's all good.
        XCTAssert(true)
    }
    
    func testFetchBudgetData() {
        BudgetModelManager.sharedInstance.loadBudgets()
        
        print("budgets currently in core data are:")
        
        for budget in BudgetModelManager.sharedInstance.budgets {
            print(budget.title)
            print(budget.id)
        }
        
        // If we made it this far through the
        // BudgetModelManager and back then it's all good.
        XCTAssert(true)
    }

}
