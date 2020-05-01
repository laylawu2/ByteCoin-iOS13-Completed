//
//  CoinData.swift
//  ByteCoin
//
//  Created by Wu, Layla on 4/30/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    /*
     {
     "time": "2020-05-01T02:04:22.7197554Z",
     "asset_id_base": "BTC",
     "asset_id_quote": "USD",
     "rate": 8692.763370157618
     }
     */
    var rate: Double
}
