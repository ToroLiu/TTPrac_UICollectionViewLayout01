//
//  TTImageSection.swift
//  DEMO
//
//  Created by aecho on 2016/5/31.
//  Copyright © 2016年 aecho. All rights reserved.
//

import UIKit

class TTImageSection: UICollectionReusableView {
    
    @IBOutlet weak var lblTitle: UILabel!

    func configure(title title:String ) {
        lblTitle.text = title
    }
}
