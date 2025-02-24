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
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {

        } else if item.tag == 1 {

        }
    }
    
}
