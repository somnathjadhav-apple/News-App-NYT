//
//  StoriesCVC.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/22/22.
//

import UIKit

class StoriesCVC: UICollectionViewCell {
    
    
    //MARK: Image
    
    static let identifier = "collectionCell"
        
        let articelImg: UIImageView = {
            let articelImg = UIImageView()
            articelImg.image = UIImage(named: "newsIcon")
            articelImg.translatesAutoresizingMaskIntoConstraints = false
        
            return articelImg
        }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
        //contentView.layer.cornerRadius = 15
        articelImg.layer.cornerRadius = 25
        contentView.addSubview(articelImg)
       
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
        articelImg.frame = CGRect(x: 5, y: 8, width: contentView.frame.size.width-10, height: contentView.frame.size.height-40)
        
    }}
