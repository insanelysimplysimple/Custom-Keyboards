//
//  Extensions.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/4/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

extension UIView {
    func flash(completionHandler: @escaping (_ done: Bool) -> Void) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }) { (completed) in
            if completed == true {
                UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseOut, animations: {
                    self.alpha = 0.0
                }, completion: { completed in
                    completionHandler(true)
                })
            }
        }
    }
}
