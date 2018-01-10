//
//  InstructionIMessageVC.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/7/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

class InstructionIMessageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = self.view.bounds.width
        let instructionPage1 = Bundle.main.loadNibNamed("InstructionPageIMessage", owner: nil, options: nil)?.first as! InstructionPageIMessage
        
        instructionPage1.frame.size.width = screenWidth
        instructionPage1.frame.origin.x = 0
        
        self.view.insertSubview(instructionPage1, at: 0)
    }


    @IBAction func btnDeleteDidTouch(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
