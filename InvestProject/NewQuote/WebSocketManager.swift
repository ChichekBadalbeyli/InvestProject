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
    weak var delegate: WebSocketManagerDelegate?

    init() {
        connect()
    }

    func connect() {
        guard let url = URL(string: "wss://investaz.az/quotes") else { return }
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        delegate?.didUpdateConnectionStatus(isConnected: true)
        receiveMessages()
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
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
            case .failure:
                self.delegate?.didUpdateConnectionStatus(isConnected: false)
            }
            self.receiveMessages()
        }
    }

    private func processReceivedText(_ text: String) {
        guard let data = text.data(using: .utf8),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
              let quotes = jsonObject as? [[String: String]] else { return }
        
        DispatchQueue.main.async {
            self.delegate?.didReceiveQuotes(quotes)
        }
    }
}
