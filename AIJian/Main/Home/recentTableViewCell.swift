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
        view.setupUI(title: "平均值", value: "\(result[0])", unit: GetUnit.getBloodUnit())
        return view
    }()
    private lazy var checkNum:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "检测次数", value: "\(result[1])", unit: "次")
        return view
    }()
    
    private lazy var highest:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "最高值", value: "\(result[2])", unit: GetUnit.getBloodUnit())
        view.ValueLabel.textColor = UIColor.orange
        
        return view
    }()
    private lazy var lowest:glucoseRecentView = {
        let view = glucoseRecentView()
        view.setupUI(title: "最低值", value: "\(result[3])", unit: GetUnit.getBloodUnit())
        return view
    }()
    
    private lazy var horizonLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    private lazy var verLine1:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    private lazy var verLine2:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
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
            make.right.equalTo(self.snp.centerX)
            make.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        checkNum.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
            make.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        highest.snp.makeConstraints{(make) in
            make.left.equalToSuperview()
            make.right.equalTo(self.snp.centerX)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        lowest.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.left.equalTo(self.snp.centerX)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        horizonLine.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.right.equalToSuperview().offset(-AJScreenWidth/20)
            make.centerY.equalToSuperview()
            make.height.equalTo(2)
        }
        
        verLine1.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(self.snp.centerY).offset(-10)
            make.width.equalTo(2)
        }
        
        verLine2.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalTo(self.snp.centerY).offset(10)
            make.width.equalTo(2)
        }
        
        
    }

}
