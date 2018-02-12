//
//  HomeViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import UINavigationBar_Addition
import KDInteractiveNavigationController
import SVProgressHUD


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet var headerView0: UIView!
    
    @IBOutlet var headerView: UIView!
    
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak  var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var featuredObjects = [Topic]()
    var latestObjects = [Topic]()
    
    let sectionsName = ["FEATURED RECIPES", "LASTEST"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        let CellNib = UINib.init(nibName: "FoudTableViewCell", bundle: nil)
        self.tableView.register(CellNib, forCellReuseIdentifier: "cell_2")
        
        //tableView.contentInsetAdjustmentBehavior = .never
        
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
        searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))
        loadDataFromNetwork()
    }
    //searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))
    
    @IBAction func openSearchViewController(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        
        navBar.hideBottomHairline()
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadDataFromNetwork() {
        
        SVProgressHUD.show()
        RequestWrapper.Topics.home { (response, error) in
            SVProgressHUD.dismiss()
            if error != nil {
                
                return
            }
            
            self.featuredObjects.removeAll()
            self.latestObjects.removeAll()
            
            self.featuredObjects.append(contentsOf: response!.featured)
            self.latestObjects.append(contentsOf: response!.latest)
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return latestObjects.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_1", for: indexPath)
                as! HomeCollectionTableViewCell
            //....
            
            cell.objects = featuredObjects
            cell.conifgureCell()
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell_2", for: indexPath) as! HomeTableViewCell
            let obj = latestObjects[indexPath.row]
            
            cell.object = obj
            cell.conifgureCell()
            
            return cell
        
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(section==0){
            headerView0.backgroundColor = UIColor.init(hex: 0xEFEFF4)
            return headerView0
        }
        else {
            headerView.backgroundColor = UIColor.init(hex: 0xEFEFF4)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==0){
            return 128
        }
        else{
            return 248
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if(section==0){
            return 24
        }
        else{
            return 16
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        footerView.backgroundColor = UIColor.init(hex: 0xEFEFF4)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let obj = latestObjects[indexPath.row]
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Recipe_OpenViewController") as! Recipe_OpenViewController
        vc.object = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

