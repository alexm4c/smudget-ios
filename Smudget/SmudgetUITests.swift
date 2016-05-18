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
        
        let collectionViewsQuery = app.alerts["New Budget"].collectionViews
        collectionViewsQuery.textFields["Enter Title Here"].typeText("Test Budget")
        collectionViewsQuery.buttons["Go"].tap()
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        let addFilledButton = element.childrenMatchingType(.Button).matchingIdentifier("Add Filled").elementBoundByIndex(0)
        addFilledButton.tap()
        
        let collectionViewsQuery3 = app.alerts["New income"].collectionViews
        let enterNameTextField = collectionViewsQuery3.textFields["Enter Name"]
        enterNameTextField.tap()
        enterNameTextField.typeText("Work")
        
        let enterValueTextField = collectionViewsQuery3.textFields["Enter Value ($$)"]
        enterValueTextField.tap()
        enterValueTextField.typeText("250")
        
        let goButton = collectionViewsQuery3.buttons["Go"]
        goButton.tap()
        addFilledButton.tap()
        enterNameTextField.typeText("App")
        enterValueTextField.tap()
        enterValueTextField.typeText("50")
        goButton.tap()
        element.childrenMatchingType(.Button).matchingIdentifier("Add Filled").elementBoundByIndex(1).tap()
        
        let collectionViewsQuery2 = app.alerts["New expense"].collectionViews
        collectionViewsQuery2.textFields["Enter Name"].typeText("Coffee")
        
        let enterValueTextField2 = collectionViewsQuery2.textFields["Enter Value ($$)"]
        enterValueTextField2.tap()
        enterValueTextField2.typeText("60")
        
        let goButton2 = collectionViewsQuery2.buttons["Go"]
        goButton2.tap()
        collectionViewsQuery2.buttons["Cancel"].tap()
        app.otherElements.containingType(.Alert, identifier:"New expense").element.tap()
        goButton2.tap()
        app.navigationBars["Smudget.BudgetView"].buttons["Main Menu"].tap()
        
    }
    
    func test2() {
        

        
    }
    
    func test3() {
        

        
    }
    
}
