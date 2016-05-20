//
//  CurrencyConverter.swift
//  Smudget
//
//  Created by Alex McBain on 16/05/2016.
//  Copyright © 2016 Alex Mc Bain. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CurrencyModel {

    private static let API_URL = "https://api.fixer.io/latest"
    
    var currencyList = [String]()
    
    init() {
        getCurrencyListFromAPI ({
            newCurrencyList in
            self.currencyList = newCurrencyList
        })
    }
    
    // Get the list of currencies that the API supports
    func getCurrencyListFromAPI(onResponse: ([String]) -> Void) {
        let url = CurrencyModel.API_URL + "?base=AUD"
        
        Alamofire.request(.GET, url).responseJSON {
            response in
            guard response.result.isSuccess else {
                return
            }
            guard let responseJSON = response.result.value as? [String:AnyObject] else {
                return
            }
            
            var newCurrencyList = [String]()
            
            let json = JSON(responseJSON)
            let rates = json["rates"]
            
            // AUD will not be returned by the API because it is the base
            newCurrencyList.append("AUD")
            
            for (key, _) in rates {
                newCurrencyList.append(key)
            }
            
            onResponse(newCurrencyList)
        }
    }
    
    // Get the specific exchange rate between the base and forCurrency currencies.
    func getRateFromAPI(base:String, forCurrency:String, onResponse: (Double?) -> Void) {
        let url = CurrencyModel.API_URL + "?base=" + base + "&symbols=" + forCurrency
        
        Alamofire.request(.GET, url).responseJSON {
            response in
            guard response.result.isSuccess else {
                return
            }
            guard let responseJSON = response.result.value as? [String:AnyObject] else {
                return
            }
            
            let json = JSON(responseJSON)
            let rate = json["rates"][forCurrency].stringValue
            
            onResponse(Double(rate))
        }
    }
    
}