//
//  AJGuidePageView.swift
//  st
//
//  Created by ADMIN on 2019/7/17.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

let HHScreenWidth = UIScreen.main.bounds.size.width
let HHScreenHeight = UIScreen.main.bounds.size.height
let statusBarHeight = UIApplication.shared.statusBarFrame.size.height


class AJGuidePageView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var imageArray:[String]?
    var guidePageView:UIScrollView!
    var imagePageControl:UIPageControl?
    
    // MARK: - /***************************View life********************************/
    /// init
    ///
    /// - Parameters:
    ///     - imageNameArray:引导页图片数组
    ///     - isHiddenSkipButton: 跳过按钮是否隐藏
    init(imageNameArray:[String],isHiddenSkipButton:Bool){
        let frame = CGRect.init(x: 0, y: 0, width: HHScreenWidth, height: HHScreenHeight)
        super.init(frame: frame)
        self.imageArray = imageNameArray
        if self.imageArray == nil || self.imageArray?.count == 0{
            return
        }
        self.addScrollView(frame:CGRect(x: 0, y: 0, width: AJScreenWidth, height: AJScreenHeight))
        self.addImages()
        self.addSkipButton(isHiddenSkipButton: isHiddenSkipButton)
        self.addPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deinit")
    }
    
}

// MARK: - /**********************************普通方法*********************************/
extension AJGuidePageView{
    func addScrollView(frame:CGRect) {
        self.guidePageView = UIScrollView.init(frame: frame)
        guidePageView.backgroundColor = UIColor.lightGray
        guidePageView.contentSize = CGSize.init(width: HHScreenWidth * (CGFloat)((self.imageArray?.count)!), height: HHScreenHeight)
        guidePageView.bounces = false
        guidePageView.isPagingEnabled = true
        guidePageView.showsHorizontalScrollIndicator = false
        guidePageView.delegate = self
        self.addSubview(guidePageView)
    }
    //  跳过按钮
    func addSkipButton(isHiddenSkipButton:Bool) -> Void {
        if isHiddenSkipButton{
            return
        }
        let skipButton = UIButton.init(frame: CGRect.init(x: HHScreenWidth * 0.75, y: HHScreenHeight * 0.1, width: 70, height: 35))
        skipButton.setTitle("Skip", for:.normal)
        skipButton.backgroundColor = UIColor.init(red: 26/255.0, green: 90/255.0, blue: 145/255.0, alpha: 0.3)
        skipButton.setTitleColor(UIColor.white, for: .normal)
        skipButton.layer.cornerRadius = skipButton.frame.size.height * 0.5
        skipButton.addTarget(self, action: #selector(skipButtonClick), for: .touchUpInside)
        self.addSubview(skipButton)
    }
    @objc func skipButtonClick(){
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }){
            (finish) in
            self.removeFromSuperview()
        }
    }
    // 添加图片
    func addImages() -> Void {
        guard let imageArray = self.imageArray else{
            return
        }
        for i in 0..<imageArray.count{
            let imageView = UIImageView.init(frame: CGRect.init(x: HHScreenWidth * CGFloat(i), y: 0, width: HHScreenWidth, height: HHScreenHeight))
            //let idString = (imageArray[i] as NSString).substring(from: imageArray[i].count - 3)
            imageView.image = UIImage.init(named: imageArray[i])
            self.guidePageView.addSubview(imageView)
            
            // 在最后一张图添加开始体验按钮
            if i == imageArray.count - 1 {
                imageView.isUserInteractionEnabled = true
                let startButton = UIButton.init(frame: CGRect.init(x: HHScreenWidth * 0.1, y: HHScreenHeight * 0.8, width: HHScreenWidth * 0.8, height: HHScreenHeight * 0.08))
                startButton.setTitle("Start experiencing", for: .normal)
                startButton.setTitleColor(UIColor.white, for: .normal)
                startButton.layer.cornerRadius = startButton.frame.size.height * 0.5
                startButton.backgroundColor = UIColor.init(red: 26/255.0, green: 90/255.0, blue: 145/255.0, alpha: 0.3)
                startButton.addTarget(self, action: #selector(skipButtonClick), for: .touchUpInside)
                imageView.addSubview(startButton)
            }
        }
    }
    // 添加转页控制
    func addPageControl() -> Void {
        // 设置引导页上的页面控制器
        self.imagePageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: HHScreenHeight*0.9, width: HHScreenWidth, height: HHScreenHeight*0.1))
        self.imagePageControl?.currentPage = 0
        self.imagePageControl?.numberOfPages = self.imageArray?.count ?? 0
        self.imagePageControl?.pageIndicatorTintColor = UIColor.gray
        self.imagePageControl?.currentPageIndicatorTintColor = UIColor.white
        self.addSubview(self.imagePageControl!)
    }
}
// MARK: - /*************************代理方法*************************/
extension AJGuidePageView:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        self.imagePageControl?.currentPage = Int(page)
    }
    
}
