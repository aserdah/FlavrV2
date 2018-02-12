//
//  CategoryTableViewCell.swift
//  Flavr
//
//  Created by Ahmed on 12/3/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var CategoryNameLabel: UILabel!
  
    
     // var object: Topic!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func conifgureCell() {
//        guard let object = object else { return }
//
//                                     // bind data
//        foudImageView.kf.setImage(with: object.image_url,
//                                  placeholder: UIImage.init(named: "placeholder"),
//                                  options: nil,
//                                  progressBlock: nil,
//                                  completionHandler: nil)
//        nameLabel.text = object.s_title
//        TypeLabel.text = object.category?.s_name
//    }

}
