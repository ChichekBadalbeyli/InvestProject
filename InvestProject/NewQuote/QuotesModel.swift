//
//  QuotesModel.swift
//  InvestProject
//
//  Created by Chichek on 28.02.25.
//
import Foundation
import Combine

class QuotesViewModel: WebSocketManagerDelegate {
    private var webSocketManager: WebSocketManager?
    private(set) var quotes: [[String: String]] = []
    private(set) var isConnected: Bool = false
    private(set) var hiddenQuotes: Set<String> = []
    
    private var quotesSubject = PassthroughSubject<[[String: String]], Never>()
    private var cancellables = Set<AnyCancellable>()
    
    var onDataUpdate: (() -> Void)?
    
    init() {
        webSocketManager = WebSocketManager()
        webSocketManager?.delegate = self
        quotesSubject
            .throttle(for: .seconds(3), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] newQuotes in
                self?.quotes = newQuotes
                self?.onDataUpdate?()
            }
            .store(in: &cancellables)
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
        return quotes
    }
    
    func didReceiveQuotes(_ quotes: [[String: String]]) {
        guard !quotes.isEmpty else { return }
        quotesSubject.send(quotes)
    }
    
    func didUpdateConnectionStatus(isConnected: Bool) {
        self.isConnected = isConnected
        onDataUpdate?()
    }
    
    func resetHiddenQuotes() {
        hiddenQuotes.removeAll()
        onDataUpdate?()
    }
}
