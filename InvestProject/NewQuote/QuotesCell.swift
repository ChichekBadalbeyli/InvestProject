//
//  QuotesCell.swift
//  InvestProject
//
//  Created by Chichek on 28.02.25.
//

import Foundation
import UIKit

class QuoteCell: UITableViewCell {
   static let reuseIdentifier = "QuoteCell"
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .blue
        return label
    }()
    
    private let changeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 10
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerStack)
        containerStack.addArrangedSubview(symbolLabel)
        containerStack.addArrangedSubview(priceLabel)
        containerStack.addArrangedSubview(changeLabel)
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with quote: [String: String], isHidden: Bool) {
        symbolLabel.text = quote["1"] ?? "N/A"
        priceLabel.text = quote["5"] ?? "N/A"
        changeLabel.text = quote["0"] == "up" ? "▲" : "▼"
        if quote["0"] == "up" {
            changeLabel.textColor = .green
        } else {
            changeLabel.textColor = .red
        }
        contentView.alpha = isHidden ? 0.5 : 1.0
    }
    
}
