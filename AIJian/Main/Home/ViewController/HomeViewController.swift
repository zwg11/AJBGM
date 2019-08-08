//
//  HomeViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var theLastGlucoseView:theLastCheckView = {
        let view = theLastCheckView()
        view.setupUI()
        return view
    }()
    
    private lazy var glucoseReView:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI()
        return view
    }()
    
    private lazy var recent7View:recentTrendView = {
        let view = recentTrendView()
        view.setUpUI()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.addSubview(theLastGlucoseView)
        theLastGlucoseView.snp.makeConstraints{(make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth/20*7)
        }
        
        self.view.addSubview(glucoseReView)
        glucoseReView.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(theLastGlucoseView.snp.bottom)
            make.height.equalTo(AJScreenWidth/20*7)
        }
        
        self.view.addSubview(recent7View)
        recent7View.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(glucoseReView.snp.bottom)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(20)
            } else {
                // Fallback on earlier versions
                make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(20)
            }
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
