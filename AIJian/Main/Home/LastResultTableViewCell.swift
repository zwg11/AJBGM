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
    
    private lazy var imageview: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "details")
        view.contentMode = .center
        
        return view
    }()
    
    private lazy var glucoseValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 60)
        label.textAlignment = .left
        // 标签显示数据库中日期最晚的血糖值
        label.text = getDataInHome.getLastGlucoseValue()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    private lazy var gUnitLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = GetUnit.getBloodUnit()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.white
//        label.backgroundColor = UIColor.yellow
        return label
    }()
    
    private lazy var rangeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        // 显示血糖正常范围
        let unit = GetUnit.getBloodUnit()
        let low = GetBloodLimit.getRandomDinnerLow()
        let high = GetBloodLimit.getRandomDinnerTop()
        if unit == "mg/dL"{
            label.text = "Reference value \(Int(low))" + unit + "-" + "\(Int(high))" + unit
        }else{
            label.text = "Reference value \(low)" + unit + "-" + "\(high)" + unit
        }
        
        label.textAlignment = .left
        label.textColor = UIColor.gray
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
        
        content.addSubview(imageview)
        imageview.snp.makeConstraints{(make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(AJScreenWidth/6)
            make.height.equalTo(AJScreenWidth/6)
        }
        
        content.addSubview(rangeLabel)
        rangeLabel.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(AJScreenWidth/10)
            make.bottom.equalToSuperview()
            make.width.equalTo(AJScreenWidth/3*2)
            //make.top.equalTo(glucoseValueLabel.snp.bottom)
            make.height.equalTo(AJScreenWidth/15)
        }
        
        content.addSubview(glucoseValueLabel)

        
        glucoseValueLabel.snp.makeConstraints{(make) in
            make.left.equalTo(rangeLabel)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalTo(rangeLabel.snp.top).offset(-10)
            make.width.equalTo(AJScreenWidth/4)
        }
        
        content.addSubview(gUnitLabel)
        gUnitLabel.snp.makeConstraints{(make) in
            make.left.equalTo(glucoseValueLabel.snp.right).offset(10)
            make.bottom.equalTo(glucoseValueLabel)
            make.height.equalTo(40)
            make.width.equalTo(AJScreenWidth/6)
        }
        
        
        //        self.layer.cornerRadius = 2
        //        self.layer.borderWidth = 1
        //        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
