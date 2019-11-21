//
//  MyCustomCollectionViewCell.swift
//  iOS_native_memory_leak_test
//
//  Created by Andrew Averin on 21/11/2019.
//  Copyright © 2019 Andrew Averin. All rights reserved.
//

import UIKit

class MyCustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
