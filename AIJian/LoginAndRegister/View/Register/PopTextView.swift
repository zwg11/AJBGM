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
        textView.text = "还未加入协议"
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
