//
//  PopTextView.swift
//  ZHFToolBox
//
//  Created by 张海峰 on 2018/5/10.
//  Copyright © 2018年 张海峰. All rights reserved.
//
/*该demo是和大家分享一下，在项目中自定义各种弹框的思路，用来支撑自己项目的使用，无论什么样的弹框，只要有思路，
相信大家都能完美实现。感觉我这个demo对你有启发或者帮助，不妨给个星星吧
    https://github.com/FighterLightning/ZHFToolBox.git
https://www.jianshu.com/p/88420bc4d32d
 */
/*弹出一个输入框*/
import UIKit
import SnapKit

class PopTextView: PopSmallChangeBigFatherView {
    let titleHeight: CGFloat = AJScreenHeight/15
    var placeHoldLable: UILabel = UILabel()
    var textView:UITextView = UITextView()
    var textStr : String = "请输入内容"
    var oneBtn:UIButton = UIButton()
    var otherBtn:UIButton = UIButton()
    override func addAnimate() {
        UIApplication.shared.keyWindow?.addSubview(self.initPopBackGroundView())
            self.isHidden = false
             //按钮不要在动画完成后初始化（否则按钮没点击效果）
            oneBtn = UIButton.init(type: UIButton.ButtonType.custom)
            otherBtn = UIButton.init(type: UIButton.ButtonType.custom)
            UIView.animate(withDuration:TimeInterval(defaultTime), animations: {
                self.WhiteView.frame = self.whiteViewEndFrame
            }) { (_) in
                self.addWhiteVieSubView1()
            }
    }
    //放一个输入框
    func addWhiteVieSubView1(){
        let titleLabel:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.WhiteView.frame.width, height: titleHeight))
        titleLabel.text = "Disclaimer"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        titleLabel.textColor = UIColor.black
        self.WhiteView.addSubview(titleLabel)
        textView = UITextView.init(frame: CGRect.init(x: AJScreenWidth/8, y: titleHeight, width: self.WhiteView.frame.width - AJScreenWidth/4, height: self.WhiteView.frame.height - titleHeight - AJScreenHeight/15))
        textView.layer.masksToBounds = true
        textView.text = ""  //这个是先清空，再设置，不要随意去掉
        textView.text = """
        Overview
        Welcome! This app is designed to help you to manage diabetes, including:
        λ    Input health data
        λ    Transfer data from your On Call blood glucose meter
        λ    Sharing the data to your healthcare provider (HCP) or caregiver
        λ    Assist in general diabetes management trough logging of contextual data
        
        Privacy Policy
        ACON respect your privacy and are committed to protecting it through our compliance with this protocol. The types of information we may collect or that you may provide when you download and register this APP. We aggregate this information and use it to help us maintain and improve our products and make them more accessible and useful. We do not share such information with third parties or combine any health information with personally identifiable information. If you do not agree with our policies and practices, do not download and register with this App. By downloading, registering, and agreeing with the terms in this document, you agree to this protocol. This protocol may change from time to time. Your continued use of this App after we make changes is deemed to be acceptance of those changes, so please check the protocol periodically for updates.
        
        This app is intended for use by a single user. Do not share the use of the app with any other user.
        The safety and security of your information also depends on you. Where we have given you (or where you have chosen) a password for access to certain parts of the App, you are responsible for keeping this password confidential. We ask you not to share your password with anyone.
        
        Unfortunately, the transmission of information via the internet and mobile platforms is not completely secure. Although we do our best to protect your personal information, we cannot guarantee the security of your personal information transmitted through the App. Any transmission of personal information is at your own risk. We are not responsible for circumvention of any privacy settings or security measures we provide.
        
        Disclaimer
        Users of this software should interpret the results in the context of their clinical history and symptoms and should not make changes in their treatment without consulting a physician or other qualified healthcare provider.
        
        Failure to perform blood glucose tests could delay treatment decisions and lead to a serious medical condition. If your physical condition does not seem to match the blood glucose value you are seeing, you may want to retest. Refer to your meter instructions for proper testing techniques. Contact your healthcare provider if you are unable to perform blood glucose testing.
        
        Uninstalling the app without making a backup of your data may result in a loss of all of your historical data. Always back up your data before updating your app or upgrading your mobile device operating system.
        
        Consult your healthcare provider about what actions you should take when using multiple time blocks and traveling to a different time zone.
        
        To ask questions or comment about this protocol, contact us at: info@aconlabs.com.
"""
        textView.layer.cornerRadius = 5
        textView.isEditable = false
        textView.backgroundColor = UIColor.white
        textView.alpha = 0.5
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 15)
        self.WhiteView.addSubview(textView)
        
        oneBtn.frame = CGRect()
        oneBtn.layer.masksToBounds = true
        oneBtn.layer.cornerRadius = 5
        oneBtn.setTitle("Sure", for: UIControl.State.normal)
        oneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        oneBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.WhiteView.addSubview(oneBtn)
        oneBtn.snp.makeConstraints{ (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(AJScreenHeight/15)
            make.bottom.equalToSuperview()
        }
        
//        otherBtn.frame = CGRect.init(x:oneBtn.frame.maxX + 10, y: self.WhiteView.frame.height - 55, width: (self.WhiteView.frame.width - 50)/2, height: 40)
//        otherBtn.layer.masksToBounds = true
//        otherBtn.layer.cornerRadius = 5
//        otherBtn.backgroundColor = UIColor.red
//        otherBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        otherBtn.setTitle("取消", for: UIControl.State.normal)
//        otherBtn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        self.WhiteView.addSubview(otherBtn)
    }
}
extension PopTextView:UITextViewDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
        textView.resignFirstResponder()
    }
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == ""{
            placeHoldLable.isHidden = false
            textView.alpha = 0.5
        }
        else{
            placeHoldLable.isHidden = true
            textView.alpha = 1
        }
    }
//    //监听return 按钮被点击
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if text == "\n" {
//            self.endEditing(true);
//            textView.resignFirstResponder;
//            return false;
//        }
//        return true;
//    }
}
