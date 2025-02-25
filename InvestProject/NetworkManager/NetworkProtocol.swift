//
//  NetworkProtocol.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//

import Foundation

protocol NetworkProtocol {
    func getConverter<T:Codable>(endpoint: ConverterEndpoint, completion:  @escaping(T?, String?)-> Void)
}


