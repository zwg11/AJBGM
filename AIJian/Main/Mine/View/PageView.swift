//
//  PageView.swift
//  page
//
//  Created by zzz on 2019/8/5.
//  Copyright © 2019 xiaozuo. All rights reserved.
//  使用帮助中的轮播图

import UIKit
import AVFoundation
import MediaPlayer

class PageView: UIView {

   
    var imageArray:[String]?
    var guidePageView:UIScrollView!   //滚动的容器
    var imagePageControl:UIPageControl?
    
    init(imageNameArray:[String]){
        let frame = CGRect.init(x: 0, y: navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight)
        super.init(frame: frame)
        self.imageArray = imageNameArray
        if self.imageArray == nil || self.imageArray?.count == 0{
            return
        }
        self.addScrollView(frame:CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight))
        self.addImages()
        self.addPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deinit")
    }
}


extension PageView{
    
    //能滚动的scroll
    func addScrollView(frame:CGRect) {
        self.guidePageView = UIScrollView.init(frame: frame)
        guidePageView.backgroundColor = UIColor.lightGray
        guidePageView.contentSize = CGSize.init(width: AJScreenWidth * (CGFloat)((self.imageArray?.count)!), height: AJScreenHeight)
        guidePageView.bounces = false
        guidePageView.isPagingEnabled = true
        guidePageView.showsHorizontalScrollIndicator = false
        guidePageView.delegate = self
        self.addSubview(guidePageView)
    }

    // 添加图片
    func addImages() -> Void {
        guard let imageArray = self.imageArray else{
            return
        }
        for i in 0..<imageArray.count{
            let imageView = UIImageView.init(frame: CGRect.init(x: AJScreenWidth * CGFloat(i), y: 0, width: AJScreenWidth, height: AJScreenHeight))
            imageView.image = UIImage.init(named: imageArray[i])
            self.guidePageView.addSubview(imageView)
        }
    }
    // 添加转页控制
    func addPageControl() -> Void {
        // 设置引导页上的页面控制器
        self.imagePageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: AJScreenHeight-2*navigationBarHeight, width: AJScreenWidth, height: AJScreenHeight*0.1))
        self.imagePageControl?.currentPage = 0
        self.imagePageControl?.numberOfPages = self.imageArray?.count ?? 0
//        self.imagePageControl?.pageIndicatorTintColoSr = UIColor.gray
//        self.imagePageControl?.currentPageIndicatorTintColor = UIColor.white
        self.addSubview(self.imagePageControl!)
    }
}
// MARK: - /*************************代理方法*************************/
extension PageView:UIScrollViewDelegate{
    
    //设置是哪张图片
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        self.imagePageControl?.currentPage = Int(page)
    }
    
}

