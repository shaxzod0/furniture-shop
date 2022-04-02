//
//  TabBarController.swift
//  Furniture shop
//
//  Created by Shaxzod Azamatjonov on 14/03/22.
//

import Foundation
import UIKit
import SOTabBar

class TabBarController: SOTabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainVC = MainVC()
        let favVC = FavoriteVC()
        let cartVC = CartVC()
        let profileVC = ProfileVC()
    
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home-sel"))
        favVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "home"), selectedImage: UIImage(named: "home-sel"))
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "cart"), selectedImage: UIImage(named:"cart-sel"))
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named:"settings"), selectedImage: UIImage(named: "set-sel"))
        viewControllers = [mainVC, favVC,cartVC,profileVC]
    }
}
