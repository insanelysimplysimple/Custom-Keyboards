//
//  LabelInstructionNumber.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/2/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

class LabelInstructionNumber: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        layer.cornerRadius = self.frame.size.height/2
        layer.masksToBounds = true
//        self.clipsToBounds = true
    }
    

}
