//
//  TTImageCell.swift
//  DEMO
//
//  Created by aecho on 2016/5/31.
//  Copyright © 2016年 aecho. All rights reserved.
//

import UIKit

class TTImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
 
    func configure(image image:UIImage, from: String, to: String) {
        imageView.image = image
        lblFrom.text = from
        lblTo.text = to
    }
    
}
