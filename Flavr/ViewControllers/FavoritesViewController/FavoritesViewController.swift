//
//  FavoritesViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class FavoritesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var objects = [Topic]()
    var page_number = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        let CellNib = UINib.init(nibName: "FoudTableViewCell", bundle: nil)
        self.tableView.register(CellNib, forCellReuseIdentifier: "cell_2")
        self.navigationController?.navigationBar.hideBottomHairline()
        //tableView.contentInsetAdjustmentBehavior = .never
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
        // Do any additional setup after loading the view.
        searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))
        
        self.tableView.es.addPullToRefresh {
            if(self.page_number>1){self.page_number -= 1}
            self.loadDataFromNetwork() // page 1
        }
        
        self.tableView.es.addInfiniteScrolling {
            self.page_number += 1
            self.loadDataFromNetwork() // next page
        }
        
        loadDataFromNetwork() // page 1 
    }
    
    //searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))
    
    @IBAction func openSearchViewController(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
    }
    
    func loadDataFromNetwork() {
        // paggination
        SVProgressHUD.show()
        RequestWrapper.Topics.listFavorite(
            i_page_number: page_number,
            i_page_count: 30,
            completionHandler: { (response, error) in
                self.tableView.es.stopPullToRefresh()
                SVProgressHUD.dismiss()
                if error != nil {
                    
                    return
                }
                
                self.objects.removeAll()
                self.objects.append(contentsOf: response!.topics)
                self.tableView.reloadData()
        })
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_2", for: indexPath) as! HomeTableViewCell
        let obj = objects[indexPath.row]

        cell.object = obj
        cell.conifgureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        headerView.backgroundColor = UIColor.init(hex: 0xEFEFF4)
        return headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        footerView.backgroundColor = UIColor.init(hex: 0xEFEFF4)
        return footerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
            return 248
       
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
            return 16
      
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let obj = objects[indexPath.row]
        
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Recipe_OpenViewController") as! Recipe_OpenViewController
        vc.object = obj
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

