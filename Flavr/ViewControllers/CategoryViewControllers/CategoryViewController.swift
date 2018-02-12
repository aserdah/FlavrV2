//
//  CategoryViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/3/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh
import Alamofire

class CategoryViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var objects = [Category]()
    var i_page_number = 1
    
    
//    let CategoryNames = ["Appetizer", "Breakfast & Brunch", "Dessert", "Beverages", "Main Dish","Pasta", "Banana MuffinSalad", "Soup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
         searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))
        self.tableView.es.addPullToRefresh {
            self.loadDataFromNetwork()
        }
        
        self.tableView.es.addInfiniteScrolling {
            self.loadDataFromNetwork() // next page
        }
        
    }
    //searchBtn.addTargetForAction(self, action: #selector(openSearchViewController))

    @IBAction func openSearchViewController(_ sender: Any) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchViewController")
        self.navigationController?.pushViewController(vc, animated: true)
        
       
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        self.setNeedsStatusBarAppearanceUpdate()
        self.interactiveNavigationBarHidden = true
        navBar.hideBottomHairline()
        super.viewDidAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromNetwork() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        RequestWrapper.Categories.list(
            i_page_number: i_page_number,
            i_page_count: 2) { (response, error) in
                self.tableView.es.stopPullToRefresh()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                var objects: [Category]!
                if (error != nil) {
                    // do something
                    self.objects.removeAll()
                    objects = Category.mr_findAll() as! [Category]
                } else {
                    if (response?.pagination.i_current_page == 1) {
                        self.objects.removeAll()
                    }
                    
                    objects = response!.categories
                }
                
                // FIX: insert duplicated items
                for obj in objects! {
                    if !self.objects.contains(obj) {
                        self.objects.append(obj)
                    }
                }
                //self.objects.append(contentsOf: objects)
                self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catecory_cell", for: indexPath) as! CategoryTableViewCell
        let obj = objects[indexPath.row]
        
        cell.CategoryNameLabel.text = obj.s_name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let obj = objects[indexPath.row]
        
        print(indexPath.row)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "Category_OpenViewController") as! Category_OpenViewController
        vc.object = obj
        //  present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



