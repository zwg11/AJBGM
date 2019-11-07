//
//  DataTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DataTableViewOfHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let glucoseLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getBloodUnit())",image: "iconxt")
        let eventLabel = tableViewCellCustomLabel.init(text: "",image: "dec_time")
        let appetiteLabel = tableViewCellCustomLabel.init(text: "",image: "appetite")
        let insulinLabel = tableViewCellCustomLabel.init(text: "U",image: "insulin")
        let weightLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getWeightUnit())",image: "weight")
        let bloodPressureLabel = tableViewCellCustomLabel.init(text: "\(GetUnit.getPressureUnit())",image: "blood pressure")
        let medicineLabel = tableViewCellCustomLabel.init(text: "",image: "medicine")
        let sportLabel = tableViewCellCustomLabel.init(text: "",image: "yundong")
        let remarkLabel = tableViewCellCustomLabel.init(text: "",image: "remark")
        let labels:[tableViewCellCustomLabel] = [glucoseLabel,eventLabel,appetiteLabel,insulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel]
        var offsetX:CGFloat = 0
        // 设置每个label的布局
        for i in labels{
            i.frame = CGRect(x: offsetX, y: 0, width: 90, height: 40)
            
            offsetX += 90
            self.addSubview(i)
        }
        // 备注信息宽度为200
        remarkLabel.frame = CGRect(x: offsetX, y: 0, width: 200, height: 40)
        self.addSubview(remarkLabel)
        self.backgroundColor = ThemeColor
        self.frame = CGRect(x: 0, y: 0, width: 9920, height: 40)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
