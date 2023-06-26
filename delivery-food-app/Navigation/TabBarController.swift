//
//  TabBarViewController.swift
//  delivery-food-app
//
//  Created by Eugene on 28.02.23.
//

import UIKit

private struct NavigationController {
    var image: String
    var selectedImage: String
    var tabBarTitle: String
    var screen: UIViewController
}

fileprivate let screenFactory = DependencyContainer.shared.screenFactory

private var controllers: [NavigationController] = [
    NavigationController(image: "menucard", selectedImage: "menucard.fill", tabBarTitle: "Меню", screen: screenFactory.createMenuVC()),
    NavigationController(image: "tag", selectedImage: "tag.fill", tabBarTitle: "Предложения", screen: screenFactory.createBenefitsVC()),
    NavigationController(image: "cart", selectedImage: "cart.fill", tabBarTitle: "Корзина", screen: screenFactory.createCartVC())
]

final class TabBarController: UITabBarController {
    private let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupTabBarAppearance()
        
        notificationCenter.addObserver(self, selector: #selector(updateTabBarBadgeValue(notification:)), name: Notification.Name("UpdateBadgeValue"), object: nil)
    }
    
    @objc func updateTabBarBadgeValue(notification: Notification) {
        if let dict = notification.userInfo as? [String: Int] {
            let count = dict["count"] ?? 0

            if (count == 0) {
                tabBar.items![2].badgeValue = nil
                return
            }

            tabBar.items![2].badgeValue = "\(count)"
        }
    }
}

extension TabBarController {
    private func setupTabBar() {
        var navigationControllers: [UINavigationController] = []
        
        for controller in controllers {
            let navigationController = setupUINavigationController(controller)

            navigationControllers.append(navigationController)
            setupNavBarApperance(navigationController)
        }

        tabBar.tintColor = .orange
        viewControllers = navigationControllers
    }
    
    private func setupUINavigationController(_ controller: NavigationController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: controller.screen)
        
        let image = UIImage(systemName: controller.selectedImage)
        let selectedImage = UIImage(systemName: controller.selectedImage)
        
        let tabItem = UITabBarItem(title: controller.tabBarTitle, image: image, selectedImage: selectedImage)
        
        navigationController.tabBarItem = tabItem
        
        return navigationController
    }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
    
    private func setupNavBarApperance(_ controller: UINavigationController) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        
        controller.navigationBar.standardAppearance = navBarAppearance
        controller.navigationBar.compactAppearance = navBarAppearance
        controller.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
