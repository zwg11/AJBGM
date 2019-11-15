//
//  recentTableViewCell.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/4.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import SwiftDate

class recentTableViewCell: UITableViewCell {

    // 即result存贮最近7天的数据的 平均值、检测次数、最高值、最低值
    let result = getDataInHome.getRecentValue(DateInRegion().dateAt(.endOfDay).date + 1.seconds - 7.days,DateInRegion().dateAt(.endOfDay).date + 1.seconds)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var average:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "Average", value: "\(result[0])", unit: GetUnit.getBloodUnit())
        return view
    }()
    private lazy var checkNum:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "Times", value: "\(result[1])", unit: "times")
        return view
    }()
    
    private lazy var highest:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "Max", value: "\(result[2])", unit: GetUnit.getBloodUnit())
        view.ValueLabel.textColor = UIColor.red
        
        return view
    }()
    private lazy var lowest:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "Min", value: "\(result[3])", unit: GetUnit.getBloodUnit())
        view.ValueLabel.textColor = UIColor.orange
        return view
    }()
    
    private lazy var horizonLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var verLine1:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    private lazy var verLine2:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        return view
    }()
    
    func setupUI(){
        self.addSubview(average)
        self.addSubview(checkNum)
        self.addSubview(highest)
        self.addSubview(lowest)
        self.addSubview(horizonLine)
        self.addSubview(verLine1)
        self.addSubview(verLine2)
        
        average.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.width.equalTo(AJScreenWidth/2)
            make.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth/4)
        }
        
        checkNum.snp.makeConstraints{(make) in
            make.left.equalTo(average.snp.right)
            make.width.equalTo(average)
            make.top.equalToSuperview()
            make.height.equalTo(AJScreenWidth/4)
        }
        
        highest.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.width.equalTo(average)
            make.bottom.equalToSuperview()
            make.height.equalTo(AJScreenWidth/4)
        }
        
        lowest.snp.makeConstraints{(make) in
            make.left.equalTo(average.snp.right)
            make.width.equalTo(average)
            make.bottom.equalToSuperview()
            make.height.equalTo(AJScreenWidth/4)
        }
        
        horizonLine.snp.makeConstraints{(make) in
            make.bottom.equalTo(average)
            make.left.equalTo(average).offset(AJScreenWidth/20)
            make.right.equalTo(checkNum).offset(-AJScreenWidth/20)
            make.height.equalTo(1)
        }
        
        verLine1.snp.makeConstraints{(make) in
            make.top.equalTo(average).offset(10)
            make.bottom.equalTo(average).offset(-10)
            make.left.equalTo(average.snp.right)
            make.width.equalTo(1)
        }
        
        verLine2.snp.makeConstraints{(make) in
            make.top.equalTo(highest).offset(10)
            make.bottom.equalTo(highest).offset(-10)
            make.left.equalTo(highest.snp.right)
            make.width.equalTo(1)
        }
        
        
    }

}
