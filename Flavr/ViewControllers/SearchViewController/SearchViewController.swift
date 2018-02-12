//
//  SearchViewController.swift
//  Flavr
//
//  Created by Training on 12/14/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var backBtn: UIBarButtonItem!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var objects = [Topic]()
    
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
        backBtn.addTargetForAction(self, action: #selector(searchBack))

        self.tableView.es.addPullToRefresh {
            self.loadDataFromNetwork() // page 1
        }
        
//        self.tableView.es.addInfiniteScrolling {
//            self.loadDataFromNetwork() // next page
//        }
        
    }
    
    @IBAction func searchBack(_ sender: Any) {
      
        self.navigationController?.popViewController(animated: true)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
    }
    
    func loadDataFromNetwork() {
        if (searchBar.text!.length < 3) { return }
        
        // paggination
        SVProgressHUD.show()
        RequestWrapper.Topics.list(
            i_category_id: nil,
            s_keyword: searchBar.text,
            i_page_number: 1,
            i_page_count: 30) { (response, error) in
                self.tableView.es.stopPullToRefresh()
                SVProgressHUD.dismiss()
                if error != nil {
                    
                    return
                }
                
                self.objects.removeAll()
                self.objects.append(contentsOf: response!.topics)
                self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadDataFromNetwork()
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
