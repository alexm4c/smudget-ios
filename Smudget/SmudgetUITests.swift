//
//  SmudgetUITest.swift
//  Smudget
//
//  Created by Alex Mc Bain on 8/04/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import XCTest

class SmudgetUITest: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test1() {
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let enterBudgetTitleTextField = app.textFields["Enter Budget Title"]
        enterBudgetTitleTextField.tap()
        
        let shiftButton = app.buttons["shift"]
        shiftButton.tap()
        enterBudgetTitleTextField.typeText("Test ")
        shiftButton.tap()
        enterBudgetTitleTextField.typeText("Budget")
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        enterBudgetTitleTextField.typeText("\n")
        app.buttons["Create!"].tap()
        
        let window = app.childrenMatchingType(.Window).elementBoundByIndex(0)
        let element = window.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.childrenMatchingType(.Button).matchingIdentifier("Add Filled").elementBoundByIndex(0).tap()
        
        let enterNameTextField = app.textFields["Enter Name"]
        enterNameTextField.tap()
        shiftButton.tap()
        enterNameTextField.typeText("Test Income")
        returnButton.tap()
        
        let textField = app.textFields["0"]
        textField.tap()
        textField.typeText("200")
        
        let doneButton = app.navigationBars["Add Budget Item"].buttons["Done"]
        doneButton.tap()
        element.childrenMatchingType(.Button).matchingIdentifier("Add Filled").elementBoundByIndex(1).tap()
        enterNameTextField.tap()
        shiftButton.tap()
        enterNameTextField.typeText("Test Expense")
        returnButton.tap()
        textField.tap()
        textField.typeText("200")
        window.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Other).element.tap()
        doneButton.tap()
        app.navigationBars["Smudget.BudgetView"].buttons["Main Menu"].tap()
        
    }
    
    func test2() {
        
        let app = XCUIApplication()
        app.buttons["Existing Budget"].tap()
        
        let myFirstBudgetStaticText = app.tables.staticTexts["My First Budget"]
        myFirstBudgetStaticText.tap()

        app.buttons["Time Filled"].tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.tap()
        element.tap()
        element.tap()
        app.navigationBars["Pie Chart"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Smudget.BudgetView"].buttons["Main Menu"].tap()
        
    }
    
    func test3() {
        
        let app = XCUIApplication()
        app.buttons["New Budget"].tap()
        
        let enterBudgetTitleTextField = app.textFields["Enter Budget Title"]
        enterBudgetTitleTextField.tap()
        enterBudgetTitleTextField.typeText("Test Budget")
        app.buttons["Create!"].tap()
        
        let mainMenuButton = app.navigationBars["Smudget.BudgetView"].buttons["Main Menu"]
        mainMenuButton.tap()
        app.buttons["Existing Budget"].tap()
        app.tables.staticTexts["Test Budget"].tap()
        mainMenuButton.tap()
        
    }
    
}
