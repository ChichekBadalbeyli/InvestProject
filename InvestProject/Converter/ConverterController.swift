//
//  ConverterController.swift
//  InvestProject
//
//  Created by Chichek on 24.02.25.
//

import UIKit

class ConverterController: ConfigureExtension, UITabBarDelegate {
    
    private let viewModel = ConverterViewModel()
    
    private var tabBarView: UITabBar = {
        let tabBar = UITabBar()
        tabBar.items = [
            UITabBarItem(title: "Currency Converter", image: UIImage(systemName: "arrow.2.squarepath"), tag: 0),
            UITabBarItem(title: "Online Quotes", image: UIImage(systemName: "chart.bar"), tag: 1)
        ]
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        return tabBar
    }()
    
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
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Convert", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let currencyPicker = UIPickerView()
    private var isSelectingPrimary = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        tabBarView.delegate = self
        configureBindings()
        
        primaryCurrencyButton.addTarget(self, action: #selector(selectPrimaryCurrency), for: .touchUpInside)
        secondaryCurrencyButton.addTarget(self, action: #selector(selectSecondaryCurrency), for: .touchUpInside)
        amountTextField.addTarget(self, action: #selector(convertCurrency), for: .editingChanged)
        
        viewModel.fetchCurrencyList()
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
        view.addSubview(convertButton)
        convertButton.translatesAutoresizingMaskIntoConstraints = false
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
            top: view.safeAreaLayoutGuide.topAnchor,
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
            bottom: convertButton.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 10, leading: 20, trailing: 20)
        )
        
        convertButton.anchor(
            top: secondaryCurrencyButton.bottomAnchor,
            bottom: resultLabel.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 10, leading: 20, trailing: 20),
            height: 50
        )
        
        resultLabel.anchor(
            top: convertButton.bottomAnchor,
            bottom: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 20, bottom: 0, leading: 20, trailing: 20)
        )
    }
    
    private func configureBindings() {
        viewModel.success = { [weak self] in
            DispatchQueue.main.async {
                self?.primaryCurrencyButton.setTitle("Select Currency", for: .normal)
                self?.secondaryCurrencyButton.setTitle("Select Currency", for: .normal)
            }
        }
        
        viewModel.error = { errorMessage in
            print("\(errorMessage)")
        }
    }
    
    
    @objc private func selectPrimaryCurrency() {
        isSelectingPrimary = true
        showCurrencyPicker()
    }
    
    @objc private func selectSecondaryCurrency() {
        isSelectingPrimary = false
        showCurrencyPicker()
    }
    
    private func showCurrencyPicker() {
        let alert = UIAlertController(title: "Select Currency", message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)
        currencyPicker.frame = CGRect(x: 0, y: 20, width: alert.view.bounds.width - 20, height: 140)
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        alert.view.addSubview(currencyPicker)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func convertCurrency() {
        guard let amountText = amountTextField.text,
              let amount = Double(amountText),
              let primaryCurrency = primaryCurrencyButton.currentTitle,
              let secondaryCurrency = secondaryCurrencyButton.currentTitle,
              primaryCurrency != "Select Currency",
              secondaryCurrency != "Select Currency" else {
            resultLabel.text = "Select Currency"
            return
        }
        
        viewModel.fetchConversion(currency: primaryCurrency, date: "2025-02-25") { convertedAmount in
            DispatchQueue.main.async {
                if let convertedAmount = convertedAmount {
                    let finalAmount = amount * convertedAmount
                    self.resultLabel.text = "\(finalAmount) \(secondaryCurrency)"
                } else {
                    self.resultLabel.text = "Select Currency"
                }
            }
        }
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            print("Currency Converter selected")
        } else if item.tag == 1 {
            print("Online Quotes selected")
        }
    }
}

extension ConverterController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.currencyStruct.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.currencyStruct[row].code
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = viewModel.currencyStruct[row].code
        
        DispatchQueue.main.async {
            if self.isSelectingPrimary {
                self.primaryCurrencyButton.setTitle(selectedCurrency, for: .normal)
            } else {
                self.secondaryCurrencyButton.setTitle(selectedCurrency, for: .normal)
            }
            
            self.primaryCurrencyButton.layoutIfNeeded()
            self.secondaryCurrencyButton.layoutIfNeeded()
            
            self.convertCurrency()
        }
    }
    
}
