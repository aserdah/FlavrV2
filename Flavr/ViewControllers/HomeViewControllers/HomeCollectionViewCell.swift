//
//  HomeCollectionViewCell.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var FoundImageView: UIImageView!
    
    var object: Topic!
    
    func conifgureCell() {
        guard let object = object else { return }
        
        FoundImageView.kf.setImage(with: object.image_url,
                                  placeholder: UIImage.init(named: "placeholder"),
                                  options: nil,
                                  progressBlock: nil,
                                  completionHandler: nil)
    }
}
