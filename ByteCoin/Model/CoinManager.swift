//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didFailWithError(error: Error)
    func didUpdatePrice(rate: String, currency: String)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "0A758125-790D-428B-A8F6-202D05956E98"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let url = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print("data \(safeData)")

                    if let rate = self.parseJSON(data: safeData) {
                        let price = String(format: "%.2f", rate)
                        self.delegate?.didUpdatePrice(rate: price, currency: currency)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            
            return rate
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
