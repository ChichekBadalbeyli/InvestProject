//
//  ConverterViewModel.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation

class ConverterViewModel {

    var convertStruct = Convertor()
    var currencyStruct = Currency()

    var success: (() -> Void)?
    var error: ((String) -> Void)?

    private let convertManager = ConverterManager()


    func fetchCurrencyList() {
        convertManager.getConverter(endpoint: .currencyEndpoint) { [weak self] (data: Currency?, err) in
            if let err = err {
                self?.error?(err)
                return
            }
            if let data = data {
                self?.currencyStruct = data
                self?.success?()
            }
        }
    }


    func fetchConversion(currency: String, date: String) {
        let endpointString = ConverterEndpoint.converterEndpoint.rawValue
            .replacingOccurrences(of: "{CURRENCY}", with: currency)
            .replacingOccurrences(of: "{DATE}", with: date)
        NetworkManager.request(model: Convertor.self, endpoint: endpointString) { [weak self] data, err in
            if let err = err {
                self?.error?(err)
                return
            }
            if let data = data {
                self?.convertStruct = data
                self?.success?()
            }
        }
    }
}
