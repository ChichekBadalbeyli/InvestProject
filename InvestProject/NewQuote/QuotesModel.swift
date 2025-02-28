//
//  QuotesModel.swift
//  InvestProject
//
//  Created by Chichek on 28.02.25.
//

import Foundation
import Combine

import Foundation

class QuotesViewModel {
    private var webSocketManager: WebSocketManager?
    private(set) var quotes: [[String: String]] = []
    private(set) var isConnected: Bool = false
    private(set) var hiddenQuotes: Set<String> = []
    
    var onDataUpdate: (() -> Void)?
    
    init() {
        webSocketManager = WebSocketManager()
        webSocketManager?.delegate = self
    }
    
    func toggleQuoteVisibility(symbol: String) {
        if hiddenQuotes.contains(symbol) {
            hiddenQuotes.remove(symbol)
        } else {
            hiddenQuotes.insert(symbol)
        }
        onDataUpdate?()
    }
    
    func filteredQuotes() -> [[String: String]] {
        return quotes.filter { quote in
            guard let symbol = quote["1"] else { return false }
            return !hiddenQuotes.contains(symbol)
        }
    }
    
}

extension QuotesViewModel: WebSocketManagerDelegate {
    func didReceiveQuotes(_ quotes: [[String: String]]) {
        self.quotes = quotes
        onDataUpdate?()
    }
    
    func didUpdateConnectionStatus(isConnected: Bool) {
        self.isConnected = isConnected
        onDataUpdate?()
    }
}
