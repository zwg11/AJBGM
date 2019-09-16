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
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
        })
        //只加入确定按钮
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func custom_cengji(_ viewController:UIViewController,_ title: String,_ message: String){
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            viewController.navigationController?.popViewController(animated: true)
        })
        //只加入确定按钮
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
