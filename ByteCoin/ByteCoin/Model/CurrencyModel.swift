//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by Игорь Волков on 02.09.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CurrencyModel {
    let coinRate: Double
    let currencyName: String
    
    var coinRateString: String {
        return String(format: "%.0f", coinRate)
    }
}
