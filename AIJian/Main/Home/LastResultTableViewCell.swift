//
//  LastResultTableViewCell.swift
//  AIJian
//
//  Created by ADMIN on 2019/9/4.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class LastResultTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private lazy var content: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 5
        return view
        
    }()
    
    private lazy var glucoseValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .center
        // 标签显示数据库中日期最晚的血糖值
        label.text = getDataInHome.getLastGlucoseValue()
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor.gray
        return label
    }()
    
    private lazy var gUnitLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = GetUnit.getBloodUnit()
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = UIColor.gray
        return label
    }()
    
    private lazy var rangeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        // 显示血糖正常范围
        label.text = "参考值 \(GetBloodLimit.getRandomDinnerLow())\(GetUnit.getBloodUnit())-\(GetBloodLimit.getRandomDinnerTop())\(GetUnit.getBloodUnit())"
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = UIColor.gray
        return label
    }()
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.accessoryType = .none
        
        self.addSubview(content)
        content.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/20)
            make.right.equalToSuperview().offset(-AJScreenWidth/20)
            make.top.bottom.equalToSuperview()
        }
        
        content.addSubview(rangeLabel)
        rangeLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/10)
            make.bottom.equalToSuperview()
            //make.top.equalTo(glucoseValueLabel.snp.bottom)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        content.addSubview(glucoseValueLabel)

        
//        // 在数据库取出最近一次的血糖记录
//        let x = DBSQLiteManager.shareManager()
//        let data = x.selectLastGlucoseRecord(UserInfo.getUserId())
//        // // 判断单位，根据相应单位取出最近一次的值
//        if GetUnit.getBloodUnit() == "mmol/L"{
//            glucoseValueLabel.text = (data.bloodGlucoseMmol != nil) ? String(data.bloodGlucoseMmol!):"-"
//        }else{
//            glucoseValueLabel.text = (data.bloodGlucoseMg != nil) ? String(data.bloodGlucoseMg!):"-"
//        }
        
        
        
        glucoseValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(rangeLabel)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(rangeLabel.snp.top).offset(-20)
            //make.height.width.equalTo(50)
        }
        
        content.addSubview(gUnitLabel)
        gUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(glucoseValueLabel.snp.right).offset(10)
            make.bottom.equalTo(glucoseValueLabel)
            make.height.equalTo(40)
        }
        
        
        //        self.layer.cornerRadius = 2
        //        self.layer.borderWidth = 1
        //        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}