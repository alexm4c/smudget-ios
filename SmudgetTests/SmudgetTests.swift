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
    
    func testBudgetExpenseCalculation() {
        
        let testExpenseValues:[Double] = [6, 7, 8, 9, 10]
        let testExpenseTotal:Double = 40
        
        let budget = Budget()
        
        for i in 0...4 {
            let expense = Budget.BudgetItem(name: "item"+String(i), value: testExpenseValues[i])
            budget.expenses.append(expense)
        }
        
        XCTAssert(budget.expenseTotal() == testExpenseTotal)
    }
    
    func testBudgetIncomeCalculation() {
        
        let testIncomeValues:[Double] = [1, 2, 3, 4, 5]
        let testIncomeTotal:Double = 15
        
        let budget = Budget()
        
        for i in 0...4 {
            let income = Budget.BudgetItem(name: "item"+String(i), value: testIncomeValues[i])
            budget.incomes.append(income)
        }
        
    	XCTAssert(budget.incomeTotal() == testIncomeTotal)
    
    }


    func testAPICurrencyList() {
        
        let asyncExpectation = expectationWithDescription("fetching currency list")
        var currencyList:[String]?
        
        CurrencyModel().getCurrencyListFromAPI({
            list in
            
            print("valid currencies returned by API are:")
            print(list)
            
            currencyList = list
            
            asyncExpectation.fulfill()
            
        })
        
        
        
        self.waitForExpectationsWithTimeout(5, handler: {
            error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            XCTAssert(currencyList != nil)
            XCTAssert(!currencyList!.isEmpty)
        })
    }
    
    func testAPIRate() {
        
        let asyncExpectation = expectationWithDescription("fetching rate")
        
        let base = "AUD"
        let currencyFor = "USD"
        
        var returnedRate:Double?
        
        CurrencyModel().getRateFromAPI(base, forCurrency: currencyFor, onResponse: {
            rate in
            print("exchange rate for AUD -> USD is " + String(rate))
            
            returnedRate = rate
            
            asyncExpectation.fulfill()

        })

        
        self.waitForExpectationsWithTimeout(5, handler: {
            error in
            
            XCTAssertNil(error, "Something went horribly wrong")
            XCTAssert(returnedRate != nil)
        })
    }
    
    
    func testBudgetModel() {
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
        
        // Saved budgets, let's see if it worked
        
        let predicate = NSPredicate(format: "title = %@", "XCT TEST BUDGET")
        let budgetObjects = BudgetModelManager.sharedInstance.fetchBudgetObjects(predicate)
        
        XCTAssert(!budgetObjects.isEmpty)
    }

}
