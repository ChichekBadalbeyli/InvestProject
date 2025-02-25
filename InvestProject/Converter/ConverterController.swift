//
//  ConverterController.swift
//  InvestProject
//
//  Created by Chichek on 24.02.25.
//

import UIKit

class ConverterController: ConfigureExtension, UITabBarDelegate {
    
    private var tabBarView: UITabBar = {
        var tabBar = UITabBar()
        tabBar.items = [
            UITabBarItem(title: "Currency Converter", image: UIImage(systemName: "arrow.2.squarepath"), tag: 0),
            UITabBarItem(title: "Online Quotes", image: UIImage(systemName: "chart.bar"), tag: 1)
        ]
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        return tabBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        tabBarView.delegate =  self
    }
    override func configureUI() {
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(primaryCurrencyButton)
        primaryCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(amountTextField)
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(secondaryCurrencyButton)
        secondaryCurrencyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func configureConstraints() {
        tabBarView.anchor(
            top: nil,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 0, bottom: 0, leading: 0, trailing: 0),
            height: 60
        )
        primaryCurrencyButton.anchor(
            top: view.topAnchor,
            bottom: amountTextField.topAnchor,
            leading: view.leadingAnchor, 
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 10, leading: 20, trailing: 20)
        )
        amountTextField.anchor(
            top: primaryCurrencyButton.bottomAnchor,
            bottom: secondaryCurrencyButton.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 10, leading: 20, trailing: 20)
        )
        secondaryCurrencyButton.anchor(
            top: amountTextField.bottomAnchor,
            bottom: resultLabel.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 10, leading: 20, trailing: 20)
        )
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            
        } else if item.tag == 1 {
            
        }
    }
    private let primaryCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Currency", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .white
        return button
    }()
    
    private let amountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Amount"
        tf.font = .systemFont(ofSize: 22, weight: .bold)
        tf.textAlignment = .center
        tf.keyboardType = .decimalPad
        tf.textColor = .white
        tf.backgroundColor = UIColor(white: 0.2, alpha: 1)
        tf.layer.cornerRadius = 8
        return tf
    }()
    
    private let secondaryCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Currency", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .white
        return button
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Converted Amount"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
}
