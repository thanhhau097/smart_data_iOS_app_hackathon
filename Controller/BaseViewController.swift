//
//  BaseViewController.swift
//  Review
//
//  Created by MAC OS on 8/27/18.
//  Copyright © 2018 MAC OS. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        
        let settingsViewController = SettingsViewController()
        
        settingsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [homeViewController, settingsViewController]
        
        viewControllers = tabBarList

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
