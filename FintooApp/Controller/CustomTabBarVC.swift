//
//  CustomTabBarVC.swift
//  FintooApp
//
//  Created by Jai Mataji on 09/03/21.
//

import UIKit
import FluidTabBarController

class CustomTabBarVC: FluidTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .red//UIColor(red: 0.2431372549, green: 0.4235294118, blue: 1, alpha: 1)
        var viewControllers:[UIViewController] = []
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let dashboardVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let dashboard = FluidTabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard"), tag: 0)
        dashboard.imageColor = .lightGray
        dashboardVC.tabBarItem = dashboard
        viewControllers.append(dashboardVC)
        
        let settingVC = storyBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        let setting = FluidTabBarItem(title: "Setting", image: #imageLiteral(resourceName: "setting"), tag: 0)
        setting.imageColor = .lightGray
        settingVC.tabBarItem = setting
        viewControllers.append(settingVC)
        
        let profileVC = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        let profile = FluidTabBarItem(title: "Profile", image: #imageLiteral(resourceName: "profile"), tag: 0)
        profile.imageColor = .lightGray
        profileVC.tabBarItem = profile
        viewControllers.append(profileVC)
        
        self.setViewControllers(viewControllers, animated: true)
    }
    

}
