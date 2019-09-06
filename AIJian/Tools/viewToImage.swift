//
//  viewToImage.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/3.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit

class viewToImage{
    class func getImageFromView(view:UIView) -> UIImage{
        //UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.main.scale)
        UIGraphicsBeginImageContext(view.bounds.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //保存图片
    @objc class func savedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        
        if error != nil {
            print("savw failed")
            
        } else {
            print("savw success")
            
        }
    }
}
