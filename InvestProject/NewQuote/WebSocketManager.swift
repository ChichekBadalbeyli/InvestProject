//
//  WebSocketManager.swift
//  InvestProject
//
//  Created by Chichek on 28.02.25.
//
import Foundation

protocol WebSocketManagerDelegate: AnyObject {
    func didReceiveQuotes(_ quotes: [[String: String]])
    func didUpdateConnectionStatus(isConnected: Bool)
}

class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?
    private let session = URLSession(configuration: .default)
    private let url = URL(string: "wss://investaz.az/quotes")!
    
    private var isConnected = false
    weak var delegate: WebSocketManagerDelegate?
    
    init() {
        connect()
    }
    
    func connect() {
        guard webSocketTask == nil else { return }
        
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        isConnected = true
        delegate?.didUpdateConnectionStatus(isConnected: true)
        
        receiveMessages()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
        isConnected = false
        delegate?.didUpdateConnectionStatus(isConnected: false)
    }
    
    private func receiveMessages() {
        webSocketTask?.receive { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    self.processReceivedText(text)
                default:
                    break
                }
                self.receiveMessages()
                
            case .failure:
                self.isConnected = false
                self.delegate?.didUpdateConnectionStatus(isConnected: false)
                self.reconnect()
            }
        }
    }
    
    private func processReceivedText(_ text: String) {
        guard let data = text.data(using: .utf8),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let quotes = jsonObject as? [[String: String]] else {
            return
        }
        
        DispatchQueue.main.async {
            self.delegate?.didReceiveQuotes(quotes)
        }
    }
    
    private func reconnect() {
        guard !isConnected else { return }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 5.0) { [weak self] in
            self?.connect()
        }
    }
}

