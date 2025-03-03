//
//  QuotesController.swift
//  InvestProject
//
//  Created by Chichek on 28.02.25.
//
import UIKit

class QuotesViewController: ConfigureExtension {
    private let tableView = UITableView()
    private let statusIndicator: UIView = {
        let statusIndicator = UIView()
        statusIndicator.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        statusIndicator.layer.cornerRadius = 6
        statusIndicator.backgroundColor = .red
        return statusIndicator
    } ()
    
    private let viewModel = QuotesViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupBindings()
        
    }
    override func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.reuseIdentifier)
        view.addSubview(tableView)
    }
    
    override func configureUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusIndicator)
        statusIndicator.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override func configureConstraints() {
        statusIndicator.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 10, bottom: 0, leading: 0, trailing: 20),
            width: 12,
            height: 12
        )
        
        tableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            constraint: (top: 0, bottom: 0, leading: 0, trailing: 0)
        )
    }
    
    private func setupBindings() {
        viewModel.onDataUpdate = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension QuotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.reuseIdentifier, for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }
        
        let quote = viewModel.quotes[indexPath.row]
        let isHidden = viewModel.hiddenQuotes.contains(quote["1"] ?? "")
        
        cell.configure(with: quote, isHidden: isHidden)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let quote = viewModel.quotes[indexPath.row]
        if let symbol = quote["1"] {
            viewModel.toggleQuoteVisibility(symbol: symbol)
        }
    }
}
