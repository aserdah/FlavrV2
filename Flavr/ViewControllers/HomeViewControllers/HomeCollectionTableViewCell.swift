//
//  HomeCollectionTableViewCell.swift
//  Flavr
//
//  Created by Ahmed on 12/2/17.
//  Copyright © 2017 Ahmed. All rights reserved.
//

import UIKit

class HomeCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var HomeCollectionView: UICollectionView!
    
    var objects: [Topic]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        HomeCollectionView.delegate = self
        HomeCollectionView.dataSource = self
    }
    
    func conifgureCell() {
        guard let objects = objects else { return }
        
        HomeCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_3", for: indexPath) as!  HomeCollectionViewCell
        let obj = objects[indexPath.item]
        
        cell.object = obj
        cell.conifgureCell()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //     let clickedIndex = imageNames[indexPath.row]
        
        //   print(clickedIndex)
        
    }
}








