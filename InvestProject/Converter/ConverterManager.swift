//
//  ConverterManager.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation

class ConverterManager: NetworkProtocol {
    func getConverter<T>(endpoint: ConverterEndpoint, completion: @escaping (T?, String?) -> Void) where T : Decodable, T : Encodable {
        NetworkManager.request(model: T.self, endpoint: endpoint.rawValue, completion:completion)
    }
}

