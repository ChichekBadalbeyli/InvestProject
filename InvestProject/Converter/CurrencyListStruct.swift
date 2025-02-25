//
//  CurrencyListStruct.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation

// MARK: - WelcomeElement
struct CurrencyListStruct: Codable {
    let code, az, en, tr: String
    let ru: String
}

typealias Currency = [CurrencyListStruct]
