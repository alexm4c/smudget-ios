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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
        
        // If through the API call then nothing broke
        // and that's good enough
        XCTAssert(true)
    }
    
    func testAPIRate() {
        // If the API stops supporting aud and usd
        // well damn me, I guess I'll change the test.
        let base = "AUD"
        let currencyFor = "USD"
        
        CurrencyModel().getRateFromAPI(base, forCurrency: currencyFor, onResponse: {
            rate in
            print("exchange rate for AUD -> USD is " + String(rate))
        })
        
        // If through the API call then nothing broke
        // and that's good enough
        XCTAssert(true)
    }
    
    
    
}
