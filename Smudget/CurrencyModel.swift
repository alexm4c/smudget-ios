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

    enum Currency:String {
        case AUD
        case CAD
        case CHF
        case CYP
        case CZK
        case DKK
        case EEK
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

    var base:Currency = .AUD
    
    
    
    
}