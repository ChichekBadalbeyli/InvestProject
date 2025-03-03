//
//  TabBarController.swift
//  InvestProject
//
//  Created by Chichek on 02.03.25.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        let quotesVC = UINavigationController(rootViewController: QuotesViewController())
        let converterVC = UINavigationController(rootViewController: ConverterController())
        
        quotesVC.tabBarItem = UITabBarItem(
            title: "Quotes",
            image: UIImage(systemName: "chart.bar"),
            tag: 1
        )
        converterVC.tabBarItem = UITabBarItem(
            title: "Converter",
            image: UIImage(systemName: "arrow.2.squarepath"),
            tag: 0
        )
        
        viewControllers = [converterVC,quotesVC]
        
        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
    }
}
