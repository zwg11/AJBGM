//
//  CustomAlertController.swift
//  AIJian
//
//  Created by zzzzzzz on 2019/8/15.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

public class CustomAlertController {
  
    /*
     此功能为自定义一个alertController。需要传入三个参数（UIViewController,头部信息，还有要传达的信息）
     */
    func custom(_ viewController:UIViewController,_ title: String,_ message: String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
        //只加入确定按钮
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func custom_cengji(_ viewController:UIViewController,_ title: String,_ message: String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
            action in
            viewController.navigationController?.popViewController(animated: false)
        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
        //只加入确定按钮
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // 弹出警示框，警示框自动消失且返回到上一视图
    func custom_autoBack(_ viewController:UIViewController,_ title: String,_ message: String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Done", style: .default, handler: {
//            action in
//            viewController.navigationController?.popViewController(animated: false)
//        })
//        okAction.setValue(UIColor.black, forKey: "_titleTextColor")
//        //只加入确定按钮
//        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: {
            sleep(1)
            alertController.dismiss(animated: true, completion: {
                // 跳转到原来的界面
                viewController.navigationController?.popToRootViewController(animated: false)
            })
            
        })
    }
}
