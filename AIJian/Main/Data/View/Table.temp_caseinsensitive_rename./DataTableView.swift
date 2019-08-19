//
//  DataTableView.swift
//  AIJian
//
//  Created by ADMIN on 2019/7/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class DataTableView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let glucoseLabel = tableViewCellCustomLabel.init(text: " mmol\\L",image: "iconxt")
        let eventLabel = tableViewCellCustomLabel.init(text: "",image: "事件")
        let appetiteLabel = tableViewCellCustomLabel.init(text: "",image: "饮食")
        let insulinLabel = tableViewCellCustomLabel.init(text: " U",image: "药丸")
        let weightLabel = tableViewCellCustomLabel.init(text: " kg",image: "体重")
        let bloodPressureLabel = tableViewCellCustomLabel.init(text: " mmHg",image: "blood pressure")
        let medicineLabel = tableViewCellCustomLabel.init(text: "",image: "用药")
        let sportLabel = tableViewCellCustomLabel.init(text: "",image: "iconxt")
        let labels:[tableViewCellCustomLabel] = [glucoseLabel,eventLabel,appetiteLabel,insulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel]
        var offsetX:CGFloat = 0
        for i in labels{
            i.frame = CGRect(x: offsetX, y: 0, width: 80, height: 40)
            
            offsetX += 80
            self.addSubview(i)
        }
        self.backgroundColor = kRGBColor(247, 243, 180, 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
