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
        convertManager.getConverter(endpoint: .currencyEndpoint) { [weak self] (data: Currency?, error) in
            if let error = error {
                self?.error?(error)
                return
            }
            if let data = data {
                self?.currencyStruct = data
                self?.success?()
            }
        }
    }


    func fetchConversion(currency: String, date: String, completion: @escaping (Double?) -> Void) {
        let endpoint = ConverterEndpoint.converterEndpoint.rawValue
            .replacingOccurrences(of: "{CURRENCY}", with: currency)
            .replacingOccurrences(of: "{DATE}", with: date)
        NetworkManager.request(model: Convertor.self, endpoint: endpoint) { [weak self] data, error in
            if let error = error {
                completion(nil)
                return
            }
            if let data = data, let result = data.first?.result {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }


}
