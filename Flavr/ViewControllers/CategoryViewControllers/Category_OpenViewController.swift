//
//  Category_OpenViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/3/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import MXParallaxHeader
import SVProgressHUD
import ESPullToRefresh
class Category_OpenViewController: UIViewController  , UITableViewDelegate, UITableViewDataSource {
    
    //  @IBOutlet weak var BackBtn: UIBarButtonItem!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var CategoryNameLabel: UILabel!
    @IBOutlet weak var RecipesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var object: Category!
    var CategoryName: String? = "Breakfast & Brunch"
    var Recipes: String? = "425 Pepole "
    var CategoryID: Int? = 1
    let imageNames = ["Featured Recipe", "Banana Muffin", "Chocolate Pudding", "Breakfast & Brunch","Featured Recipe", "Banana Muffin", "Chocolate Pudding", "Breakfast & Brunch","Featured Recipe", "Banana Muffin", "Chocolate Pudding", "Breakfast & Brunch"]
    
    var objects = [Topic]()
    var page_number = 1
    
    override func viewDidLoad() {
        UIApplication.shared.statusBarStyle = .lightContent
        self.setNeedsStatusBarAppearanceUpdate()
        super.viewDidLoad()
        
        tableView.delegate = self
        //tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.parallaxHeader.view = headerView
        tableView.parallaxHeader.height = 320
        tableView.parallaxHeader.mode = .bottom
        tableView.parallaxHeader.minimumHeight = 100
        
        
        let CellNib = UINib.init(nibName: "CategoryTableViewCell", bundle: nil)
        self.tableView.register(CellNib, forCellReuseIdentifier: "cell_2")
        self.interactiveNavigationBarHidden = true
        
        // setup style
        categoryImage.kf.indicatorType = .activity
        
        // bind data
        
        CategoryNameLabel.text = object.s_name?.uppercased()
        RecipesLabel.text = Recipes?.uppercased()
      
        categoryImage.kf.setImage(with: object.image_url,
                                  placeholder: UIImage.init(named: "placeholder"),
                                  options: nil,
                                  progressBlock: nil,
                                  completionHandler: nil)
        
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .lightContent
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
        
        //self.dismiss(animated: true, completion: nil)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_2", for: indexPath) as! HomeTableViewCell
        
       // cell.foudImageView.image = UIImage(named: imageNames[indexPath.row])
        let obj = objects[indexPath.row]
        
        cell.object = obj
        cell.conifgureCell()
        
        return cell
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 232
        
        
    }
    
    func loadDataFromNetwork() {
        // paggination
        SVProgressHUD.show()
        RequestWrapper.Topics.list(i_category_id: object.pk_i_id?.intValue,
                                   s_keyword: "",
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
    
    
    
}


