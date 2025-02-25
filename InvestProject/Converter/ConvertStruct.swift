//
//  ConvertStruct.swift
//  InvestProject
//
//  Created by Chichek on 25.02.25.
//
import Foundation

// MARK: - WelcomeElement
struct ConvertStruct: Codable {
    let from, to: String
    let result: Double
    let date, menbe: String
}

typealias Convertor = [ConvertStruct]
