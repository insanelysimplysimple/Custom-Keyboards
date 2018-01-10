//
//  InstructionVC.swift
//  Frenchie Clone
//
//  Created by Jayven Nhan on 5/1/17.
//  Copyright © 2017 Jayven Nhan. All rights reserved.
//

import UIKit

class InstructionVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = self.view.bounds.width
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: screenWidth * 2, height: self.view.bounds.height)
        
        let instructionPage1 = Bundle.main.loadNibNamed("InstructionPage1", owner: nil, options: nil)?.first as! InstructionPage1
        let instructionPage2 = Bundle.main.loadNibNamed("InstructionPage2", owner: nil, options: nil)?.first as! InstructionPage2
        
        instructionPage1.frame.size.width = screenWidth
        instructionPage1.frame.origin.x = 0
        instructionPage2.frame.size.width = screenWidth
        instructionPage2.frame.origin.x = self.view.bounds.size.width
        
        scrollView.addSubview(instructionPage1)
        scrollView.addSubview(instructionPage2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCancelDidTouch(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension InstructionVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(page)
    }
}
