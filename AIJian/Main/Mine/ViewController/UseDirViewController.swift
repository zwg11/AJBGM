//
//  UseDirViewController.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/2.
//  Copyright © 2019 apple. All rights reserved.
//  用户使用指导页

import UIKit
import SnapKit


class UseDirViewController: UIViewController,UIScrollViewDelegate{

     var scrollView:UIScrollView?
    
    // 设置导航栏左按钮样式
    private lazy var leftButton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "back"), for: .normal)
        //button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(leftButtonClick), for: .touchUpInside)
        return button
    }()
   
    
    lazy var text_title:UILabel = {
        let text_title = UILabel()
        text_title.font = UIFont.boldSystemFont(ofSize: 18)
        text_title.text = "How to transfer the data from meter to the On Call app:"
        text_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_title.numberOfLines = 0
        text_title.textColor = TextColor
        return text_title
    }()
    // step one
    lazy var text_step_one:UILabel = {
        let text_step_one = UILabel()
        text_step_one.font = UIFont.systemFont(ofSize: 16)
        text_step_one.text = " 1. Switch on the Bluetooth of your phone."
        text_step_one.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_one.numberOfLines = 0
        text_step_one.textColor = TextColor
        return text_step_one
    }()
    lazy var img_step_one:UIImageView = {
        let img_step_one = UIImageView()
        img_step_one.image = UIImage(named:"step_one")
        return img_step_one
    }()
    // step two
    lazy var text_step_two:UILabel = {
        let text_step_two = UILabel()
        text_step_two.font = UIFont.systemFont(ofSize: 16)
        text_step_two.text = " 2. Plug the On Call Bluetooth adapter into the On Call glucose meter."
        text_step_two.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_two.numberOfLines = 0
        text_step_two.textColor = TextColor
        return text_step_two
    }()
    lazy var img_step_two:UIImageView = {
        let img_step_two = UIImageView()
        img_step_two.image = UIImage(named:"step_two")
        return img_step_two
    }()
    // step three
    lazy var text_step_three:UILabel = {
        let text_step_three = UILabel()
        text_step_three.font = UIFont.systemFont(ofSize: 16)
        text_step_three.text = " 3. Switch on the On Call Bluetooth adapter by press the button on the adapter."
        text_step_three.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_three.numberOfLines = 0
        text_step_three.textColor = TextColor
        return text_step_three
    }()
    lazy var img_step_three:UIImageView = {
        let img_step_three = UIImageView()
        img_step_three.image = UIImage(named:"step_three")
        return img_step_three
    }()
    // step four
       lazy var text_step_four:UILabel = {
           let text_step_four = UILabel()
           text_step_four.font = UIFont.systemFont(ofSize: 16)
           text_step_four.text = " 4. The meter shall enter into the Data Transfer Mode (PC Mode) before transferring. Please find the methods below* for entering into the Data Transfer Mode for different On Call glucose meter models."
           text_step_four.lineBreakMode = NSLineBreakMode.byCharWrapping
           text_step_four.numberOfLines = 0
           text_step_four.textColor = TextColor
           return text_step_four
       }()
       lazy var img_step_four:UIImageView = {
           let img_step_four = UIImageView()
           img_step_four.image = UIImage(named:"step_four")
           return img_step_four
       }()
    // step five
    lazy var text_step_five:UILabel = {
        let text_step_five = UILabel()
        text_step_five.font = UIFont.systemFont(ofSize: 16)
        text_step_five.text = " 5. In On Call app, Click “Add”, and then click “Bluetooth Transfer” (the data can also be manually inputted), and then click “Scan”. The Bluetooth adapter SN will show on the screen. And then click the SN, it will start to download the data from meter directly. "
        text_step_five.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_five.numberOfLines = 0
        text_step_five.textColor = TextColor
        return text_step_five
    }()
    // step six
    lazy var text_step_six:UILabel = {
        let text_step_six = UILabel()
        text_step_six.font = UIFont.systemFont(ofSize: 16)
        text_step_six.text = " 6. During the data transfer, the meter will display \"to\" and \"PC\". This indicates the data is being transferred from the meter to the On Call app. Once the data transfer is complete, the meter will display \"End\" and \"PC\", and after a moment the meter will turn itself off. "
        text_step_six.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_six.numberOfLines = 0
        text_step_six.textColor = TextColor
        return text_step_six
    }()
    lazy var img_step_six_left:UIImageView = {
        let img_step_six_left = UIImageView()
        img_step_six_left.image = UIImage(named:"step_six_one")
        return img_step_six_left
    }()
    lazy var img_step_six_right:UIImageView = {
        let img_step_six_right = UIImageView()
        img_step_six_right.image = UIImage(named:"step_six_two")
        return img_step_six_right
    }()
    // step seven
    lazy var text_step_seven:UILabel = {
        let text_step_seven = UILabel()
        text_step_seven.font = UIFont.systemFont(ofSize: 16)
        text_step_seven.text = " 7. After downloaded, click “Save” if you want to save the data in On Call app. And then you can analyze the data or share with your healthcare providers. "
        text_step_seven.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_step_seven.numberOfLines = 0
        text_step_seven.textColor = TextColor
        return text_step_seven
    }()
    lazy var text_title_start:UILabel = {
        let text_title_start = UILabel()
        text_title_start.font = UIFont.boldSystemFont(ofSize: 18)
        text_title_start.text = " *Note: Only when the meter enters into the PC Mode, the data can be transferred from the meter to On Call app. Different models of meter have different method to enter into the PC Mode:"
        text_title_start.textColor = TextColor
        text_title_start.lineBreakMode = NSLineBreakMode.byCharWrapping
        text_title_start.numberOfLines = 0
        return text_title_start
    }()
    //ocp
    lazy var on_call_plus_title:UILabel = {
        let on_call_plus_title = UILabel()
        on_call_plus_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_plus_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_plus_title.numberOfLines = 0
        on_call_plus_title.text = "On Call Plus"
        on_call_plus_title.textColor = TextColor
        return on_call_plus_title
    }()
    lazy var on_call_plus_enter_title:UILabel = {
        let on_call_plus_enter_title = UILabel()
        on_call_plus_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_plus_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_plus_enter_title.numberOfLines = 0
        on_call_plus_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_plus_enter_title.textColor = TextColor
        return on_call_plus_enter_title
    }()
    lazy var on_call_plus_enter_content:UILabel = {
        let on_call_plus_enter_content = UILabel()
        on_call_plus_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_plus_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_plus_enter_content.numberOfLines = 0
        on_call_plus_enter_content.text = "Press and hold the S button on the meter to enter the data transfer mode. \"PC\" will appear on the display."
        on_call_plus_enter_content.textColor = TextColor
        return on_call_plus_enter_content
    }()
    lazy var on_call_plus_exit_title:UILabel = {
        let on_call_plus_exit_title = UILabel()
        on_call_plus_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_plus_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_plus_exit_title.numberOfLines = 0
        on_call_plus_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_plus_exit_title.textColor = TextColor
        return on_call_plus_exit_title
    }()
    lazy var on_call_plus_exit_content:UILabel = {
        let on_call_plus_exit_content = UILabel()
        on_call_plus_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_plus_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_plus_exit_content.numberOfLines = 0
        on_call_plus_exit_content.text = " If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the S button. This will turn the meter off and exit the PC mode."
        on_call_plus_exit_content.textColor = TextColor
        return on_call_plus_exit_content
    }()
    lazy var on_call_plus_use_title:UILabel = {
           let on_call_plus_use_title = UILabel()
           on_call_plus_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_plus_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_plus_use_title.numberOfLines = 0
           on_call_plus_use_title.text = " How to use On Call Plus:"
           on_call_plus_use_title.textColor = TextColor
           return on_call_plus_use_title
       }()
       lazy var on_call_plus_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=34&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_plus_use_content = UILabel()
           on_call_plus_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_plus_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_plus_use_content.numberOfLines = 0
           on_call_plus_use_content.attributedText = attributedText
           on_call_plus_use_content.textColor = TextColor
        on_call_plus_use_content.isUserInteractionEnabled = true
        on_call_plus_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCPlus")))
           return on_call_plus_use_content
       }()
    //oce
    
    lazy var on_call_extra_title:UILabel = {
        let on_call_extra_title = UILabel()
        on_call_extra_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_extra_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_extra_title.numberOfLines = 0
        on_call_extra_title.text = "On Call Extra"
        on_call_extra_title.textColor = TextColor
        return on_call_extra_title
    }()
    lazy var on_call_extra_enter_title:UILabel = {
        let on_call_extra_enter_title = UILabel()
        on_call_extra_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_extra_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_extra_enter_title.numberOfLines = 0
        on_call_extra_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_extra_enter_title.textColor = TextColor
        return on_call_extra_enter_title
    }()
    lazy var on_call_extra_enter_content:UILabel = {
        let on_call_extra_enter_content = UILabel()
        on_call_extra_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_extra_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_extra_enter_content.numberOfLines = 0
        on_call_extra_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_extra_enter_content.textColor = TextColor
        return on_call_extra_enter_content
    }()
    lazy var on_call_extra_exit_title:UILabel = {
        let on_call_extra_exit_title = UILabel()
        on_call_extra_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_extra_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_extra_exit_title.numberOfLines = 0
        on_call_extra_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_extra_exit_title.textColor = TextColor
        return on_call_extra_exit_title
    }()
    lazy var on_call_extra_exit_content:UILabel = {
        let on_call_extra_exit_content = UILabel()
        on_call_extra_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_extra_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_extra_exit_content.numberOfLines = 0
        on_call_extra_exit_content.text = "If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the Right button. This will turn the meter off and exit the PC mode."
        on_call_extra_exit_content.textColor = TextColor
        return on_call_extra_exit_content
    }()
    lazy var on_call_extra_use_title:UILabel = {
           let on_call_extra_use_title = UILabel()
           on_call_extra_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_extra_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_extra_use_title.numberOfLines = 0
           on_call_extra_use_title.text = " How to use On Call Extra:"
           on_call_extra_use_title.textColor = TextColor
           return on_call_extra_use_title
       }()
       lazy var on_call_extra_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=28&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_extra_use_content = UILabel()
           on_call_extra_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_extra_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_extra_use_content.numberOfLines = 0
           on_call_extra_use_content.attributedText = attributedText
           on_call_extra_use_content.textColor = TextColor
            on_call_extra_use_content.isUserInteractionEnabled = true
           on_call_extra_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCExtra")))
           return on_call_extra_use_content
       }()
    //oc vivid
    lazy var on_call_vivid_title:UILabel = {
        let on_call_vivid_title = UILabel()
        on_call_vivid_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_vivid_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_vivid_title.numberOfLines = 0
        on_call_vivid_title.text = "On Call Vivid"
        on_call_vivid_title.textColor = TextColor
        return on_call_vivid_title
    }()
    lazy var on_call_vivid_enter_title:UILabel = {
        let on_call_vivid_enter_title = UILabel()
        on_call_vivid_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_vivid_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_vivid_enter_title.numberOfLines = 0
        on_call_vivid_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_vivid_enter_title.textColor = TextColor
        return on_call_vivid_enter_title
    }()
    lazy var on_call_vivid_enter_content:UILabel = {
        let on_call_vivid_enter_content = UILabel()
        on_call_vivid_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_vivid_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_vivid_enter_content.numberOfLines = 0
        on_call_vivid_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_vivid_enter_content.textColor = TextColor
        return on_call_vivid_enter_content
    }()
    lazy var on_call_vivid_exit_title:UILabel = {
        let on_call_vivid_exit_title = UILabel()
        on_call_vivid_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_vivid_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_vivid_exit_title.numberOfLines = 0
        on_call_vivid_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_vivid_exit_title.textColor = TextColor
        return on_call_vivid_exit_title
    }()
    lazy var on_call_vivid_exit_content:UILabel = {
        let on_call_vivid_exit_content = UILabel()
        on_call_vivid_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_vivid_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_vivid_exit_content.numberOfLines = 0
        on_call_vivid_exit_content.text = " If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the Power button. This will turn the meter off and exit the PC mode."
        on_call_vivid_exit_content.textColor = TextColor
        return on_call_vivid_exit_content
    }()
    lazy var on_call_vivid_use_title:UILabel = {
           let on_call_vivid_use_title = UILabel()
           on_call_vivid_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_vivid_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_vivid_use_title.numberOfLines = 0
           on_call_vivid_use_title.text = " How to use On Call Vivid:"
           on_call_vivid_use_title.textColor = TextColor
           return on_call_vivid_use_title
       }()
       lazy var on_call_vivid_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=98&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_vivid_use_content = UILabel()
           on_call_vivid_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_vivid_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_vivid_use_content.numberOfLines = 0
           on_call_vivid_use_content.attributedText = attributedText
           on_call_vivid_use_content.textColor = TextColor
        on_call_vivid_use_content.isUserInteractionEnabled = true
        on_call_vivid_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCVivid")))
           return on_call_vivid_use_content
       }()
    //oc Sure
    lazy var on_call_sure_title:UILabel = {
        let on_call_sure_title = UILabel()
        on_call_sure_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sure_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sure_title.numberOfLines = 0
        on_call_sure_title.text = "On Call Sure"
        on_call_sure_title.textColor = TextColor
        return on_call_sure_title
    }()
    lazy var on_call_sure_enter_title:UILabel = {
        let on_call_sure_enter_title = UILabel()
        on_call_sure_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sure_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sure_enter_title.numberOfLines = 0
        on_call_sure_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_sure_enter_title.textColor = TextColor
        return on_call_sure_enter_title
    }()
    lazy var on_call_sure_enter_content:UILabel = {
        let on_call_sure_enter_content = UILabel()
        on_call_sure_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_sure_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sure_enter_content.numberOfLines = 0
        on_call_sure_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_sure_enter_content.textColor = TextColor
        return on_call_sure_enter_content
    }()
    lazy var on_call_sure_exit_title:UILabel = {
        let on_call_sure_exit_title = UILabel()
        on_call_sure_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sure_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sure_exit_title.numberOfLines = 0
        on_call_sure_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_sure_exit_title.textColor = TextColor
        return on_call_sure_exit_title
    }()
    lazy var on_call_sure_exit_content:UILabel = {
        let on_call_sure_exit_content = UILabel()
        on_call_sure_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_sure_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sure_exit_content.numberOfLines = 0
        on_call_sure_exit_content.text = " If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the OK button. This will turn the meter off and exit the PC mode."
        on_call_sure_exit_content.textColor = TextColor
        return on_call_sure_exit_content
    }()
    lazy var on_call_sure_use_title:UILabel = {
           let on_call_sure_use_title = UILabel()
           on_call_sure_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_sure_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_sure_use_title.numberOfLines = 0
           on_call_sure_use_title.text = " How to use On Call Sure:"
           on_call_sure_use_title.textColor = TextColor
           return on_call_sure_use_title
       }()
       lazy var on_call_sure_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=32&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_sure_use_content = UILabel()
           on_call_sure_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_sure_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_sure_use_content.numberOfLines = 0
           on_call_sure_use_content.attributedText = attributedText
           on_call_sure_use_content.textColor = TextColor
          on_call_sure_use_content.isUserInteractionEnabled = true
          on_call_sure_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCPlus")))
           return on_call_sure_use_content
       }()
    //oc sharp
    lazy var on_call_sharp_title:UILabel = {
        let on_call_sharp_title = UILabel()
        on_call_sharp_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sharp_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sharp_title.numberOfLines = 0
        on_call_sharp_title.text = "On Call Sharp"
        on_call_sharp_title.textColor = TextColor
        return on_call_sharp_title
    }()
    lazy var on_call_sharp_enter_title:UILabel = {
        let on_call_sharp_enter_title = UILabel()
        on_call_sharp_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sharp_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sharp_enter_title.numberOfLines = 0
        on_call_sharp_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_sharp_enter_title.textColor = TextColor
        return on_call_sharp_enter_title
    }()
    lazy var on_call_sharp_enter_content:UILabel = {
        let on_call_sharp_enter_content = UILabel()
        on_call_sharp_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_sharp_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sharp_enter_content.numberOfLines = 0
        on_call_sharp_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_sharp_enter_content.textColor = TextColor
        return on_call_sharp_enter_content
    }()
    lazy var on_call_sharp_exit_title:UILabel = {
        let on_call_sharp_exit_title = UILabel()
        on_call_sharp_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_sharp_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sharp_exit_title.numberOfLines = 0
        on_call_sharp_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_sharp_exit_title.textColor = TextColor
        return on_call_sharp_exit_title
    }()
    lazy var on_call_sharp_exit_content:UILabel = {
        let on_call_sharp_exit_content = UILabel()
        on_call_sharp_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_sharp_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_sharp_exit_content.numberOfLines = 0
        on_call_sharp_exit_content.text = "If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the Power button. This will turn the meter off and exit the PC mode."
        on_call_sharp_exit_content.textColor = TextColor
        return on_call_sharp_exit_content
    }()
    lazy var on_call_sharp_use_title:UILabel = {
           let on_call_sharp_use_title = UILabel()
           on_call_sharp_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_sharp_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_sharp_use_title.numberOfLines = 0
           on_call_sharp_use_title.text = " How to use On Call Sharp:"
           on_call_sharp_use_title.textColor = TextColor
           return on_call_sharp_use_title
       }()
       lazy var on_call_sharp_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=35&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_sharp_use_content = UILabel()
           on_call_sharp_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_sharp_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_sharp_use_content.numberOfLines = 0
           on_call_sharp_use_content.attributedText = attributedText
           on_call_sharp_use_content.textColor = TextColor
           on_call_sharp_use_content.isUserInteractionEnabled = true
           on_call_sharp_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCSharp")))
           return on_call_sharp_use_content
       }()
    //oc advanced
    lazy var on_call_advanced_title:UILabel = {
        let on_call_advanced_title = UILabel()
        on_call_advanced_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_advanced_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_advanced_title.numberOfLines = 0
        on_call_advanced_title.text = "On Call Advanced"
        on_call_advanced_title.textColor = TextColor
        return on_call_advanced_title
    }()
    lazy var on_call_advanced_enter_title:UILabel = {
        let on_call_advanced_enter_title = UILabel()
        on_call_advanced_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_advanced_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_advanced_enter_title.numberOfLines = 0
        on_call_advanced_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_advanced_enter_title.textColor = TextColor
        return on_call_advanced_enter_title
    }()
    lazy var on_call_advanced_enter_content:UILabel = {
        let on_call_advanced_enter_content = UILabel()
        on_call_advanced_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_advanced_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_advanced_enter_content.numberOfLines = 0
        on_call_advanced_enter_content.text = "Press the M and S buttons to enter the data transfer mode. “PC” will appear on the display when the meter enters the data transfer mode."
        on_call_advanced_enter_content.textColor = TextColor
        return on_call_advanced_enter_content
    }()
    lazy var on_call_advanced_exit_title:UILabel = {
        let on_call_advanced_exit_title = UILabel()
        on_call_advanced_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_advanced_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_advanced_exit_title.numberOfLines = 0
        on_call_advanced_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_advanced_exit_title.textColor = TextColor
        return on_call_advanced_exit_title
    }()
    lazy var on_call_advanced_exit_content:UILabel = {
        let on_call_advanced_exit_content = UILabel()
        on_call_advanced_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_advanced_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_advanced_exit_content.numberOfLines = 0
        on_call_advanced_exit_content.text = " If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the S button. This will turn the meter off and exit the PC mode."
        on_call_advanced_exit_content.textColor = TextColor
        return on_call_advanced_exit_content
    }()
    lazy var on_call_advanced_use_title:UILabel = {
           let on_call_advanced_use_title = UILabel()
           on_call_advanced_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_advanced_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_advanced_use_title.numberOfLines = 0
           on_call_advanced_use_title.text = " How to use On Call Advanced:"
           on_call_advanced_use_title.textColor = TextColor
           return on_call_advanced_use_title
       }()
       lazy var on_call_advanced_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=33&lcid=4"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_advanced_use_content = UILabel()
           on_call_advanced_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_advanced_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_advanced_use_content.numberOfLines = 0
           on_call_advanced_use_content.attributedText = attributedText
           on_call_advanced_use_content.textColor = TextColor
            on_call_advanced_use_content.isUserInteractionEnabled = true
           on_call_advanced_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCAdvanced")))
           return on_call_advanced_use_content
       }()
    //oc gkd
    lazy var on_call_gkd_title:UILabel = {
        let on_call_gkd_title = UILabel()
        on_call_gkd_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gkd_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gkd_title.numberOfLines = 0
        on_call_gkd_title.text = "On Call GK Dual"
        on_call_gkd_title.textColor = TextColor
        return on_call_gkd_title
    }()
    lazy var on_call_gkd_enter_title:UILabel = {
        let on_call_gkd_enter_title = UILabel()
        on_call_gkd_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gkd_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gkd_enter_title.numberOfLines = 0
        on_call_gkd_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_gkd_enter_title.textColor = TextColor
        return on_call_gkd_enter_title
    }()
    lazy var on_call_gkd_enter_content:UILabel = {
        let on_call_gkd_enter_content = UILabel()
        on_call_gkd_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_gkd_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gkd_enter_content.numberOfLines = 0
        on_call_gkd_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_gkd_enter_content.textColor = TextColor
        return on_call_gkd_enter_content
    }()
    lazy var on_call_gkd_exit_title:UILabel = {
        let on_call_gkd_exit_title = UILabel()
        on_call_gkd_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gkd_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gkd_exit_title.numberOfLines = 0
        on_call_gkd_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_gkd_exit_title.textColor = TextColor
        return on_call_gkd_exit_title
    }()
    lazy var on_call_gkd_exit_content:UILabel = {
        let on_call_gkd_exit_content = UILabel()
        on_call_gkd_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_gkd_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gkd_exit_content.numberOfLines = 0
        on_call_gkd_exit_content.text = " If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the Right button. This will turn the meter off and exit the PC mode."
        on_call_gkd_exit_content.textColor = TextColor
        return on_call_gkd_exit_content
    }()
    lazy var on_call_gkd_use_title:UILabel = {
           let on_call_gkd_use_title = UILabel()
           on_call_gkd_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_gkd_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_gkd_use_title.numberOfLines = 0
           on_call_gkd_use_title.text = " How to use On Call GK Dual:"
           on_call_gkd_use_title.textColor = TextColor
           return on_call_gkd_use_title
       }()
       lazy var on_call_gkd_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=120&lcid=3"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_gkd_use_content = UILabel()
           on_call_gkd_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_gkd_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_gkd_use_content.numberOfLines = 0
           on_call_gkd_use_content.attributedText = attributedText
           on_call_gkd_use_content.textColor = TextColor
        on_call_gkd_use_content.isUserInteractionEnabled = true
        on_call_gkd_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCGKDual")))
           return on_call_gkd_use_content
       }()
    //oc gud
    lazy var on_call_gud_title:UILabel = {
        let on_call_gud_title = UILabel()
        on_call_gud_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gud_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gud_title.numberOfLines = 0
        on_call_gud_title.text = "On Call GU Dual"
        on_call_gud_title.textColor = TextColor
        return on_call_gud_title
    }()
    lazy var on_call_gud_enter_title:UILabel = {
        let on_call_gud_enter_title = UILabel()
        on_call_gud_enter_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gud_enter_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gud_enter_title.numberOfLines = 0
        on_call_gud_enter_title.text = "How to enter into Data Transfer Mode:"
        on_call_gud_enter_title.textColor = TextColor
        return on_call_gud_enter_title
    }()
    lazy var on_call_gud_enter_content:UILabel = {
        let on_call_gud_enter_content = UILabel()
        on_call_gud_enter_content.font = UIFont.systemFont(ofSize: 16)
        on_call_gud_enter_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gud_enter_content.numberOfLines = 0
        on_call_gud_enter_content.text = "After Plugging the On Call Bluetooth adapter and turn it on, the meter will automatically turn itself into the data transfer mode. \"PC\" will appear on the display."
        on_call_gud_enter_content.textColor = TextColor
        return on_call_gud_enter_content
    }()
    lazy var on_call_gud_exit_title:UILabel = {
        let on_call_gud_exit_title = UILabel()
        on_call_gud_exit_title.font = UIFont.boldSystemFont(ofSize: 18)
        on_call_gud_exit_title.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gud_exit_title.numberOfLines = 0
        on_call_gud_exit_title.text = " How to exit the Data Transfer Mode:"
        on_call_gud_exit_title.textColor = TextColor
        return on_call_gud_exit_title
    }()
    lazy var on_call_gud_exit_content:UILabel = {
        let on_call_gud_exit_content = UILabel()
        on_call_gud_exit_content.font = UIFont.systemFont(ofSize: 16)
        on_call_gud_exit_content.lineBreakMode = NSLineBreakMode.byCharWrapping
        on_call_gud_exit_content.numberOfLines = 0
        on_call_gud_exit_content.text = "If you entered the data transfer mode but want to exit before performing the data transfer procedure, press the Right button. This will turn the meter off and exit the PC mode."
        on_call_gud_exit_content.textColor = TextColor
        return on_call_gud_exit_content
    }()
    lazy var on_call_gud_use_title:UILabel = {
           let on_call_gud_use_title = UILabel()
           on_call_gud_use_title.font = UIFont.boldSystemFont(ofSize: 18)
           on_call_gud_use_title.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_gud_use_title.numberOfLines = 0
           on_call_gud_use_title.text = " How to use On Call GU Dual:"
           on_call_gud_use_title.textColor = TextColor
           return on_call_gud_use_title
       }()
       lazy var on_call_gud_use_content:UILabel = {
           let text = "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=121&lcid=3"
           let textRange = NSMakeRange(0,text.count)
           let attributedText = NSMutableAttributedString(string:text)
           attributedText.addAttribute(NSAttributedString.Key.underlineStyle,value: NSUnderlineStyle.single.rawValue, range: textRange)
           let on_call_gud_use_content = UILabel()
           on_call_gud_use_content.font = UIFont.systemFont(ofSize: 16)
           on_call_gud_use_content.lineBreakMode = NSLineBreakMode.byCharWrapping
           on_call_gud_use_content.numberOfLines = 0
           on_call_gud_use_content.attributedText = attributedText
           on_call_gud_use_content.textColor = TextColor
        on_call_gud_use_content.isUserInteractionEnabled = true
        on_call_gud_use_content.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector.init("clickOCGUDual")))
           return on_call_gud_use_content
       }()
  
    override func viewWillAppear(_ animated: Bool) {
        self.scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.automaticallyAdjustsScrollViewInsets = false
        self.title="Instruction"
        
//        self.view.backgroundColor = ThemeColor
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
       
        scrollView = UIScrollView()
        scrollView!.contentSize = CGSize(width: self.view.frame.size.width, height: 3400*2-1000)
        scrollView!.alwaysBounceVertical = true
        scrollView!.showsVerticalScrollIndicator = true
        scrollView!.isScrollEnabled = true
        
        let imageGroup: [String] = ["step_five_one","step_five_two","step_five_three"]
        let guideView = PageView.init(imageNameArray: imageGroup)
              
        let imageGroupSeven: [String] = ["step_seven_one","step_seven_two","step_seven_three"]
        let guideViewSeven = PageView.init(imageNameArray: imageGroupSeven)

        self.view.addSubview(scrollView!)
        scrollView!.snp.makeConstraints{(make) in
            make.left.right.equalToSuperview()
//            make.top.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
            }
        }
        
        
        scrollView!.addSubview(text_title)
        text_title.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(50)
//            make.top.equalTo(topLayoutGuide.snp.bottom).offset(5)
            make.top.equalToSuperview()
        }
        //step_one--------------------------------------
        scrollView!.addSubview(text_step_one)
        text_step_one.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(text_title.snp.bottom).offset(5)
        }
        scrollView?.addSubview(img_step_one)
        img_step_one.snp.makeConstraints{ (make) in
            make.width.equalTo(400)
            make.height.equalTo(200)
            make.top.equalTo(text_step_one.snp.bottom).offset(5)
        }
        //step_two--------------------------------------
        scrollView!.addSubview(text_step_two)
        text_step_two.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(45)
            make.top.equalTo(img_step_one.snp.bottom).offset(5)
        }
        scrollView!.addSubview(img_step_two)
        img_step_two.snp.makeConstraints{ (make) in
            make.width.equalTo(400)
            make.height.equalTo(200)
            make.top.equalTo(text_step_two.snp.bottom).offset(5)
        }
        //step_three--------------------------------------
        scrollView!.addSubview(text_step_three)
        text_step_three.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(45)
            make.top.equalTo(img_step_two.snp.bottom).offset(5)
        }
        scrollView!.addSubview(img_step_three)
        img_step_three.snp.makeConstraints{ (make) in
            make.width.equalTo(200)
            make.height.equalTo(350)
            make.top.equalTo(text_step_three.snp.bottom).offset(5)
        }
        //step_four--------------------------------------
        scrollView!.addSubview(text_step_four)
        text_step_four.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalTo(img_step_three.snp.bottom).offset(5)
        }
        scrollView!.addSubview(img_step_four)
        img_step_four.snp.makeConstraints{ (make) in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(text_step_four.snp.bottom).offset(5)
        }
        //step_five--------------------------------------
        scrollView!.addSubview(text_step_five)
        text_step_five.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(130)
            make.top.equalTo(img_step_four.snp.bottom).offset(10)
        }
        //hava picture
        scrollView!.addSubview(guideView)
        guideView.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(self.view)
            make.top.equalTo(text_step_five.snp.bottom).offset(10)
        }
        //step_six--------------------------------------
        scrollView!.addSubview(text_step_six)
        text_step_six.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(180)
            make.top.equalTo(guideView.snp.bottom).offset(10)
        }
        
        scrollView!.addSubview(img_step_six_left)
        img_step_six_left.snp.makeConstraints{ (make) in
            make.width.equalTo(AJScreenWidth/2-2)
            make.height.equalTo(200)
            make.top.equalTo(text_step_six.snp.bottom).offset(10)
        }
        scrollView!.addSubview(img_step_six_right)
        img_step_six_right.snp.makeConstraints{ (make) in
            make.left.equalTo(AJScreenWidth/2+4)
            make.width.equalTo(AJScreenWidth/2-2)
            make.height.equalTo(200)
            make.top.equalTo(text_step_six.snp.bottom).offset(10)
        }
        //step_seven--------------------------------------
        scrollView!.addSubview(text_step_seven)
        text_step_seven.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(img_step_six_left.snp.bottom).offset(10)
        }
        
        scrollView!.addSubview(guideViewSeven)
        guideViewSeven.snp.makeConstraints{ (make) in
            make.width.equalToSuperview()
            make.height.equalTo(self.view)
            make.top.equalTo(text_step_seven.snp.bottom).offset(10)
        }
        // all_title
        scrollView!.addSubview(text_title_start)
        text_title_start.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(180)
            make.top.equalTo(guideViewSeven.snp.bottom).offset(10)
        }
        //on call plus
        scrollView!.addSubview(on_call_plus_title)
        on_call_plus_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(text_title_start.snp.bottom).offset(5)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_plus_enter_title)
        on_call_plus_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_plus_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_plus_enter_content)
        on_call_plus_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(60)
            make.top.equalTo(on_call_plus_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_plus_exit_title)
        on_call_plus_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_plus_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_plus_exit_content)
        on_call_plus_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_plus_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_plus_use_title)
        on_call_plus_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_plus_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_plus_use_content)
        on_call_plus_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_plus_use_title.snp.bottom).offset(3)
        }
        
        //oce
        scrollView!.addSubview(on_call_extra_title)
        on_call_extra_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_plus_use_content.snp.bottom).offset(40)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_extra_enter_title)
        on_call_extra_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_extra_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_extra_enter_content)
        on_call_extra_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_extra_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_extra_exit_title)
        on_call_extra_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_extra_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_extra_exit_content)
        on_call_extra_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_extra_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_extra_use_title)
        on_call_extra_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_extra_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_extra_use_content)
        on_call_extra_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_extra_use_title.snp.bottom).offset(3)
        }
        //ocv------------------------------------------------------------------------------
        scrollView!.addSubview(on_call_vivid_title)
        on_call_vivid_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_extra_use_content.snp.bottom).offset(40)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_vivid_enter_title)
        on_call_vivid_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_vivid_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_vivid_enter_content)
        on_call_vivid_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_vivid_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_vivid_exit_title)
        on_call_vivid_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_vivid_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_vivid_exit_content)
        on_call_vivid_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_vivid_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_vivid_use_title)
        on_call_vivid_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_vivid_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_vivid_use_content)
        on_call_vivid_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_vivid_use_title.snp.bottom).offset(3)
        }
//        //ocs--------------------------------------------------------
//        scrollView!.addSubview(on_call_sure_title)
//        on_call_sure_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_vivid_use_content.snp.bottom).offset(40)
//        }
//        //how to enter into Data Transfer Mode
//        scrollView!.addSubview(on_call_sure_enter_title)
//        on_call_sure_enter_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(30)
//            make.top.equalTo(on_call_sure_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_sure_enter_content)
//        on_call_sure_enter_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(80)
//            make.top.equalTo(on_call_sure_enter_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_sure_exit_title)
//        on_call_sure_exit_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_sure_enter_content.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_sure_exit_content)
//        on_call_sure_exit_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(80)
//            make.top.equalTo(on_call_sure_exit_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_sure_use_title)
//        on_call_sure_use_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_sure_exit_content.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_sure_use_content)
//        on_call_sure_use_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(40)
//            make.top.equalTo(on_call_sure_use_title.snp.bottom).offset(3)
//        }
        //on call sharp--------------------------------
        scrollView!.addSubview(on_call_sharp_title)
        on_call_sharp_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_vivid_use_content.snp.bottom).offset(40)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_sharp_enter_title)
        on_call_sharp_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_sharp_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_sharp_enter_content)
        on_call_sharp_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_sharp_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_sharp_exit_title)
        on_call_sharp_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_sharp_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_sharp_exit_content)
        on_call_sharp_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_sharp_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_sharp_use_title)
        on_call_sharp_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_sharp_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_sharp_use_content)
        on_call_sharp_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_sharp_use_title.snp.bottom).offset(3)
        }
        // oc advanced------------------------------
        scrollView!.addSubview(on_call_advanced_title)
        on_call_advanced_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_sharp_use_content.snp.bottom).offset(40)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_advanced_enter_title)
        on_call_advanced_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_advanced_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_advanced_enter_content)
        on_call_advanced_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_advanced_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_advanced_exit_title)
        on_call_advanced_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_advanced_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_advanced_exit_content)
        on_call_advanced_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_advanced_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_advanced_use_title)
        on_call_advanced_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_advanced_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_advanced_use_content)
        on_call_advanced_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_advanced_use_title.snp.bottom).offset(3)
        }
        // oc gkd------------------------------------------------
        scrollView!.addSubview(on_call_gkd_title)
        on_call_gkd_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_advanced_use_content.snp.bottom).offset(40)
        }
        //how to enter into Data Transfer Mode
        scrollView!.addSubview(on_call_gkd_enter_title)
        on_call_gkd_enter_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalTo(on_call_gkd_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_gkd_enter_content)
        on_call_gkd_enter_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_gkd_enter_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_gkd_exit_title)
        on_call_gkd_exit_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_gkd_enter_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_gkd_exit_content)
        on_call_gkd_exit_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(80)
            make.top.equalTo(on_call_gkd_exit_title.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_gkd_use_title)
        on_call_gkd_use_title.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(on_call_gkd_exit_content.snp.bottom).offset(3)
        }
        scrollView!.addSubview(on_call_gkd_use_content)
        on_call_gkd_use_content.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(on_call_gkd_use_title.snp.bottom).offset(3)
        }
        // oc gud---------------------------------------
//        scrollView!.addSubview(on_call_gud_title)
//        on_call_gud_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_gkd_use_content.snp.bottom).offset(40)
//        }
//        //how to enter into Data Transfer Mode
//        scrollView!.addSubview(on_call_gud_enter_title)
//        on_call_gud_enter_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(30)
//            make.top.equalTo(on_call_gud_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_gud_enter_content)
//        on_call_gud_enter_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(80)
//            make.top.equalTo(on_call_gud_enter_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_gud_exit_title)
//        on_call_gud_exit_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_gud_enter_content.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_gud_exit_content)
//        on_call_gud_exit_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(80)
//            make.top.equalTo(on_call_gud_exit_title.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_gud_use_title)
//        on_call_gud_use_title.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(20)
//            make.top.equalTo(on_call_gud_exit_content.snp.bottom).offset(3)
//        }
//        scrollView!.addSubview(on_call_gud_use_content)
//        on_call_gud_use_content.snp.makeConstraints{(make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(40)
//            make.top.equalTo(on_call_gud_use_title.snp.bottom).offset(3)
//        }
//
//
        
    }
    
    @objc private func leftButtonClick(){
        self.navigationController?.popViewController(animated: false)
    }
    @objc private func clickOCPlus(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=34&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    @objc private func clickOCExtra(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=28&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    @objc private func clickOCVivid(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=98&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    @objc private func clickOCSure(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=32&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    
    @objc private func clickOCSharp(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=35&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    @objc private func clickOCAdvanced(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=33&lcid=4")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    @objc private func clickOCGKDual(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=120&lcid=3")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
    
    @objc private func clickOCGUDual(){
        let updateUrl:URL = URL.init(string: "http://www.acondiabetescare.com/productcenter/info.aspx?itemid=121&lcid=3")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(updateUrl)
        }
    }
}

