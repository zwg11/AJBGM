//
//  StatisticalDataView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class StatisticalDataView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private lazy var averageTitle:UITextView = {
       let view = UITextView()
        view.text = "Average"
        view.textColor = UIColor.black
        return view
    }()
    
    private lazy var globalTitle:UITextView = {
        let view = UITextView()
        view.text = "Average"
        view.textColor = UIColor.black
        return view
    }()
    
    private lazy var preMealTitle:UITextView = {
        let view = UITextView()
        view.text = "Average"
        view.textColor = UIColor.black
        return view
    }()
    
    private lazy var afterMealTitle:UITextView = {
        let view = UITextView()
        view.text = "Average"
        view.textColor = UIColor.black
        return view
    }()

}
