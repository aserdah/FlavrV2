//
//  FlavrTabBarController.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//


import UIKit
import AZTabBar
import KDInteractiveNavigationController
import UINavigationBar_Addition


class FlavrTabBarController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        var icons = [String]()
        
        icons.append("ic_home_grey")
        icons.append("ic_recipes_grey")
        icons.append("ic_favorites_grey")
        icons.append("ic_profile_grey")
        
        self.navigationController?.navigationBar.hideBottomHairline()
        // override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
        self.navigationController?.navigationBar.setColors(background: UIColor.init(hex: 0xEFEFF4)!, text: UIColor.black)
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.navigationBar.hideBottomHairline()
        //The icons that will be displayed for each tab once they are selected.
        var selectedIcons = [String]()
        selectedIcons.append("ic_home_orange")
        selectedIcons.append("ic_recipes_orange")
        selectedIcons.append("ic_favorites_orange")
        selectedIcons.append("ic_profile_orange")
        
        let tabController = AZTabBarController.insert(into: self, withTabIconNames: icons, andSelectedIconNames: selectedIcons)
        //if you are using storyboard:
        let HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController")
        let ProfileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
        let CategoryViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CategoryViewController")
        let FavoritesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FavoritesViewController")
        //if you are loading programmatically:
        // let myChildViewController = myChildViewController()
        
        tabController.setViewController(HomeViewController, atIndex: 0)
        tabController.setViewController(CategoryViewController, atIndex: 1)
        tabController.setViewController(FavoritesViewController, atIndex: 2)
        tabController.setViewController(ProfileViewController, atIndex: 3)
        
        tabController.selectedColor = .orange
        tabController.animateTabChange = true
        tabController.selectionIndicatorColor = .orange
        tabController.selectionIndicatorHeight = 4
        tabController.highlightsSelectedButton = true
        
        
        tabController.highlightedBackgroundColor = .green
        tabController.defaultColor = .lightGray
        tabController.buttonsBackgroundColor = .white
        tabController.highlightColor = .green
        
        
        tabController.separatorLineVisible = true
        self.interactiveNavigationBarHidden = true
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.hideBottomHairline()
        self.interactiveNavigationBarHidden = true
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        super.viewDidAppear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        
        self.navigationController?.navigationBar.hideBottomHairline()
        super.viewDidAppear(true)
        
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


