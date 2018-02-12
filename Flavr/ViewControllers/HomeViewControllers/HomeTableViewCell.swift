//
//  HomeTableViewCell.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var foudImageView: UIImageView!
    @IBOutlet weak var TypeLabel: UILabel!
    @IBOutlet weak var recipesLabel: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var durationLabel: UIButton!
    @IBOutlet weak var difficultyLabel: UIButton!
    
    var object: Topic!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // setup styles
        foudImageView.kf.indicatorType = .activity
    }

    func conifgureCell() {
        guard let object = object else { return }
        
        // bind data
        foudImageView.kf.setImage(with: object.image_url,
                                  placeholder: UIImage.init(named: "placeholder"),
                                  options: nil,
                                  progressBlock: nil,
                                  completionHandler: nil)
        nameLabel.text = object.s_title
        TypeLabel.text = object.category?.s_name
        //recipesLabel.text = "6 People"
    }
    

}
