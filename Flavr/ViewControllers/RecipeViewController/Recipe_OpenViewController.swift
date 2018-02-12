//
//  Recipe_OpenViewController.swift
//  Flavr
//
//  Created by Ahmed on 12/5/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import MXParallaxHeader
import SVProgressHUD

class Recipe_OpenViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var lblTopicName: UILabel!
    @IBOutlet weak var imgTopicImage: UIImageView!
    @IBOutlet weak var btnFavorite: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    var object: Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.setNeedsStatusBarAppearanceUpdate()
        
        //scrollView.contentInsetAdjustmentBehavior = .never

        scrollView.parallaxHeader.view = headerView;
        scrollView.parallaxHeader.height = 360;
        scrollView.parallaxHeader.mode = .bottom
        scrollView.parallaxHeader.minimumHeight = 140
        
        self.interactiveNavigationBarHidden = true

        
        // setup style
        imgTopicImage.kf.indicatorType = .activity
        
        // bind data
        lblCategoryName.text = object.category?.s_name
        lblTopicName.text = object.s_title
        imgTopicImage.kf.setImage(with: object.image_url,
                                  placeholder: UIImage.init(named: "placeholder"),
                                  options: nil,
                                  progressBlock: nil,
                                  completionHandler: nil)
        if object.dt_favorite_date != nil {
            btnFavorite.setImage(UIImage.init(named: "ic_favorites_orange"), for: UIControlState.normal)
        } else {
            btnFavorite.setImage(UIImage.init(named: "ic_favorite"), for: UIControlState.normal)
        }
        
        // ....
        
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoritesBtnTapped(_ sender: Any) {
        if object.dt_favorite_date != nil {
            SVProgressHUD.show()
            RequestWrapper.Topics.removeFavorite(
                i_topic_id: object.pk_i_id!.intValue,
                completionHandler: { (response, error) in
                    SVProgressHUD.dismiss()
                    if error != nil {
                        
                        return
                    }
                    
                    self.btnFavorite.setImage(UIImage.init(named: "ic_favorite"), for: UIControlState.normal)
            })
        } else {
            RequestWrapper.Topics.addFavorite(
                i_topic_id: object.pk_i_id!.intValue,
                completionHandler: { (response, error) in
                    SVProgressHUD.dismiss()
                    if error != nil {
                        
                        return
                    }
                    
                    self.btnFavorite.setImage(UIImage.init(named: "ic_favorites_orange"), for: UIControlState.normal)
            })
        }
        
    }
}
