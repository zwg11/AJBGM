//
//  dataTableViewCell.swift
//  AIJian
//
//  Created by ADMIN on 2019/8/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class dataTableViewCell: UITableViewCell {
    
    var glucoseLabel:UILabel = UILabel()
    var eventLabel:UILabel = UILabel()
    var appetiteLabel:UILabel = UILabel()
    var isulinLabel:UILabel = UILabel()
    
//    var heightLabel:UILabel = UILabel()
    var weightLabel:UILabel = UILabel()
    var bloodPressureLabel:UILabel = UILabel()
    var medicineLabel: UILabel = UILabel()
    var sportLabel:UILabel = UILabel()
    var modelLabel:UILabel = UILabel()
    var remarkLabel:UILabel = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,secion:Int,row:Int){
//        print("sortedData：\(sortedData[secion][row])")
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        // 清空该cell的内容
//        while self.contentView.subviews.last != nil{
//            self.contentView.subviews.last?.removeFromSuperview()
//        }
        // 被选中的背景,设为无
        self.selectionStyle = .none
        // 设置单元格颜色
        self.backgroundColor = UIColor.clear
//        self.backgroundColor = ThemeColor
        // 血糖
        // 如果血糖不为空
        if let gluBlood = sortedData[secion][row].bloodGlucoseMmol{
            // 根据单位设置不同形式的值
            if GetUnit.getBloodUnit() == "mmol/L"{
                glucoseLabel.text =  "\(gluBlood)"
            }else{
                glucoseLabel.text = String(format:"%.0f",sortedData[secion][row].bloodGlucoseMg!)
            }
        }// 否则为 “-”
        else{
            glucoseLabel.text =  "-"
        }
        
        // 事件
        eventLabel.font = UIFont.systemFont(ofSize: 15)
        eventLabel.minimumScaleFactor = 0.3
        eventLabel.adjustsFontSizeToFitWidth = true
        eventLabel.text = (sortedData[secion][row].detectionTime != nil) ? EvenChang.numToeven(Int(sortedData[secion][row].detectionTime!)):"-"
        // 进餐量
        appetiteLabel.font = UIFont.systemFont(ofSize: 15)
        appetiteLabel.minimumScaleFactor = 0.3
        appetiteLabel.adjustsFontSizeToFitWidth = true
        appetiteLabel.text = (sortedData[secion][row].eatNum != nil) ? EatNumChange.numToeat(Int(sortedData[secion][row].eatNum!)):"-"
        
        // 先判断有没有胰岛素量，若没有再判断有没有胰岛素类型
        // 胰岛素类型和量
        isulinLabel.font = UIFont.systemFont(ofSize: 15)
        isulinLabel.minimumScaleFactor = 0.3
        isulinLabel.adjustsFontSizeToFitWidth = true
        if sortedData[secion][row].insulinNum != nil{
            isulinLabel.text = String(sortedData[secion][row].insulinNum!) + "U\n" +  String(sortedData[secion][row].insulinType!)
            isulinLabel.font = UIFont.systemFont(ofSize: 10)
        }else if sortedData[secion][row].insulinType != nil{
            isulinLabel.text = String(sortedData[secion][row].insulinType!)
        }
        else{
            isulinLabel.text = "-"
        }
        // 身高
//        heightLabel.text = (sortedData[secion][row].height != nil) ? String(sortedData[secion][row].height!):"-"
        // 体重
        // 如果体重不为空
        if let weight = sortedData[secion][row].weightKg{
            // 根据单位设置不同形式的值
            if GetUnit.getWeightUnit() == "kg"{
                weightLabel.text =  "\(weight)"
            }else{
                weightLabel.text =  String(format: "%.0f", sortedData[secion][row].weightLbs!)
            }
        }// 否则为 “-”
        else{
            weightLabel.text = "-"
        }
        
        
        // 血压
        // 如果血压不为空
        if let pressure = sortedData[secion][row].systolicPressureMmhg{
            // 根据单位设置不同形式的值
            if GetUnit.getPressureUnit() == "mmHg"{
                bloodPressureLabel.text =  String(format:"%.0f",pressure) + "/" + String(format:"%.0f",sortedData[secion][row].diastolicPressureMmhg ?? 0)
            }else{
                bloodPressureLabel.text =  String(sortedData[secion][row].systolicPressureKpa!) + "/" + String(sortedData[secion][row].diastolicPressureKpa!)
            }
        }// 否则为 “-”
        else{
            bloodPressureLabel.text = "-"
        }
        
        // 药物
        medicineLabel.font = UIFont.systemFont(ofSize: 15)
        medicineLabel.minimumScaleFactor = 0.3
        medicineLabel.adjustsFontSizeToFitWidth = true
        medicineLabel.text = sortedData[secion][row].medicine ?? "-"
        
        // 先判断有没有运动量，若没有再判断有没有运动类型
        // 运动
        sportLabel.font = UIFont.systemFont(ofSize: 15)
        sportLabel.minimumScaleFactor = 0.3
        sportLabel.adjustsFontSizeToFitWidth = true
        if sortedData[secion][row].sportTime != nil{
            sportLabel.text = String(sortedData[secion][row].sportType!) + "\n" + String(sortedData[secion][row].sportTime!) + "min"
            
        }else if sortedData[secion][row].sportType != nil && sortedData[secion][row].sportType != "None"{

            sportLabel.text = String(sortedData[secion][row].sportType!)
        }
        else{
            sportLabel.text = "-"
        }
        // 输入类型
        if sortedData[secion][row].inputType == 0{
            modelLabel = tableViewCellCustomLabel.init(text: "", image: "蓝牙图标")
        }else{
            modelLabel = tableViewCellCustomLabel.init(text: "", image:  "手动输入图标")
        }
        modelLabel.backgroundColor = UIColor.clear
        
        // 备注
        remarkLabel.textAlignment = .center
        if let remarkText = sortedData[secion][row].remark{
            remarkLabel.text = remarkText
        }else{
            remarkLabel.text = "-"
        }
        
        
        let labels:[UILabel] = [glucoseLabel,eventLabel,appetiteLabel,isulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel,modelLabel,remarkLabel]
        
        var offsetX:CGFloat = 0
        for i in labels{
            //i.font = UIFont.systemFont(ofSize: 12)
            i.frame = CGRect(x: offsetX, y: 0, width: 90, height: 40)
            i.textAlignment = .center
            i.numberOfLines = 0
            i.textColor = UIColor.white
            offsetX += 90
            self.contentView.addSubview(i)
        }
        SetColorOfLabelText.SetGlucoseTextColor(sortedData[secion][row], label: glucoseLabel)
        remarkLabel.frame.size.width = 200
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
