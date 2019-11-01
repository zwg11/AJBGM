//
//  AboutUsViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  关于我们

import UIKit

class ProtocalViewController: UIViewController {
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
    var scrollView:UIScrollView = UIScrollView()
    let textView = UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        //        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        
        //        let textView = UITextView(frame: CGRect(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight))
        
        
        let ABOUTUS_STRING = """
        Overview
                Welcome! This app is designed to help you to manage diabetes, including:
                * Input health data
                * Transfer data from your On Call blood glucose meter
                * Sharing the data to your healthcare provider (HCP) or caregiver
                * Assist in general diabetes management trough logging of contextual data

        Privacy Policy
                ACON respect your privacy and are committed to protecting it through our compliance with this protocol. The types of information we may collect or that you may provide when you download and register this APP. We aggregate this information and use it to help us maintain and improve our products and make them more accessible and useful. We do not share such information with third parties or combine any health information with personally identifiable information. If you do not agree with our policies and practices, do not download and register with this App. By downloading, registering, and agreeing with the terms in this document, you agree to this protocol. This protocol may change from time to time. Your continued use of this App after we make changes is deemed to be acceptance of those changes, so please check the protocol periodically for updates.

                This app is intended for use by a single user. Do not share the use of the app with any other user.The safety and security of your information also depends on you. Where we have given you (or where you have chosen) a password for access to certain parts of the App, you are responsible for keeping this password confidential. We ask you not to share your password with anyone.

                Unfortunately, the transmission of information via the internet and mobile platforms is not completely secure. Although we do our best to protect your personal information, we cannot guarantee the security of your personal information transmitted through the App. Any transmission of personal information is at your own risk. We are not responsible for circumvention of any privacy settings or security measures we provide.

        Disclaimer
                Users of this software should interpret the results in the context of their clinical history and symptoms and should not make changes in their treatment without consulting a physician or other qualified healthcare provider.

                Failure to perform blood glucose tests could delay treatment decisions and lead to a serious medical condition. If your physical condition does not seem to match the blood glucose value you are seeing, you may want to retest. Refer to your meter instructions for proper testing techniques. Contact your healthcare provider if you are unable to perform blood glucose testing.

                Uninstalling the app without making a backup of your data may result in a loss of all of your historical data. Always back up your data before updating your app or upgrading your mobile device operating system.

                Consult your healthcare provider about what actions you should take when using multiple time blocks and traveling to a different time zone.

                To ask questions or comment about this protocol, contact us at: info@aconlabs.com.
        """
        //        textView.backgroundColor = ThemeColor
        textView.backgroundColor = UIColor.clear
        textView.font = UIFont.boldSystemFont(ofSize: 16)
        textView.textColor = TextColor
        textView.isEditable = false
        textView.textAlignment = .left
        
        textView.text = ABOUTUS_STRING
        
        scrollView.contentSize = CGSize(width: AJScreenWidth, height: AJScreenHeight+1)
        scrollView.showsVerticalScrollIndicator = true
        
        // 添加滚动视图
        scrollView.backgroundColor = UIColor.clear
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        self.scrollView.addSubview(textView)
        textView.snp.remakeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalTo(topLayoutGuide.snp.bottom)
        }
        
        
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
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


