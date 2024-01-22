//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, currency: CurrencyModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = currency.coinRateString
            self.currencyLabel.text = currency.currencyName
        }
    }
    
    func didFailWithError(_ coinManager: CoinManager, error: Error) {
        print(error)
    }
}

//MARK: - UIPickerView DataSource & Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}
