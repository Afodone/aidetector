//
//  ViewController.swift
//  AIDetector
//
//  Created by yong on 2025/7/24.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = aid_000000
        
        let home = AIDHomeViewController()
        let navHome = UINavigationController(rootViewController: home)
        
        
        let explore = AIDExploreViewController()
        let navExplore = UINavigationController(rootViewController: explore)
        
     
        let setting = AIDSettingViewController()
        let navSetting = UINavigationController(rootViewController: setting)
        
        self.viewControllers = [navHome,navExplore,navSetting]
                
        let titleList = [AIDString.localized("Home"),AIDString.localized("Explore"),AIDString.localized("Settings")]
    
        let iconList = ["tab_home","tab_explore","tab_setting"]
        let iconList1 = ["tab_home1","tab_explore1","tab_setting1"]

        
        for i:Int in 0...2 {
            let title = titleList[i]
            self.viewControllers?[i].tabBarItem.title = title
            self.viewControllers?[i].tabBarItem.image = .init(named: iconList[i])?.withRenderingMode(.alwaysOriginal)
            self.viewControllers?[i].tabBarItem.selectedImage = .init(named: iconList1[i])?.withRenderingMode(.alwaysOriginal)
        }
       
        tabBar.unselectedItemTintColor = aid_9CA3AF
        tabBar.tintColor = aid_8B5CEF
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowColor = aid_000000.withAlphaComponent(0.2)
        appearance.backgroundColor = .clear
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            // Fallback on earlier versions
        }
    }


}

