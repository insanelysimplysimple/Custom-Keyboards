//
//  Emoji.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/4/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

class Emoji {
    
    var image: UIImage?
    
    init(imageName: String) {
        if let image = UIImage(named: imageName) {
            self.image = image
        }
    }
    
}
