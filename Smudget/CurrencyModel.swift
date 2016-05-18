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
    
    // These are the currencies that the API supports
    enum Currency:String {
        case AUD
        case CAD
        case CHF
        case CYP
        case CZK
        case DKK
        case EEK
        case EUR
        case GBP
        case HKD
        case HUF
        case ISK
        case JPY
        case KRW
        case LTL
        case LVL
        case MTL
        case NOK
        case NZD
        case PLN
        case ROL
        case SEK
        case SGD
        case SIT
        case SKK
        case TRL
        case USD
        case ZAR
    }
    
    func getRateFromAPI(base:Currency, forCurrency:Currency, onResponse: (Double?) -> Void) {
        
        let url = CurrencyModel.API_URL + "?base=" + base.rawValue + "&symbols=" + forCurrency.rawValue
        
        Alamofire.request(.GET, url).responseJSON {
            response in
            guard response.result.isSuccess else {
                return
            }
            guard let responseJSON = response.result.value as? [String:AnyObject] else {
                return
            }
            
            let rateData = JSON(responseJSON)
            
            let rate = rateData["rates"][forCurrency.rawValue].stringValue
            
            onResponse(Double(rate))
        }
    }
    
}