//
//  ConverterEndpoint.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation

enum ConverterEndpoint: String {
    case converterEndpoint = "/api/get_currency_rate_for_app/{CURRENCY}/{DATE}"
    case currencyEndpoint = "/api/get_currency_list_for_app"
}
