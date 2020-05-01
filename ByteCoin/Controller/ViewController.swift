//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var byteCoinLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        coinManager.delegate = self
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
}

extension ViewController: CoinManagerDelegate {
    func didUpdatePrice(rate: String, currency: String) {
        print("rate: \(rate), currency: \(currency)")
        DispatchQueue.main.async {
            self.priceLabel.text = rate
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print("error: \(error)")
    }
}
