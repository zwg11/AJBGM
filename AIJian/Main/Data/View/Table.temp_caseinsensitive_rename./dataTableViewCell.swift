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
    var remarkLabel:UILabel = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,secion:Int,row:Int){
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        // 血糖
        if GetUnit.getBloodUnit() == "mmol/L"{
            glucoseLabel.text = (sortedData[secion][row].bloodGlucoseMmol != nil) ? String(sortedData[secion][row].bloodGlucoseMmol!):"-"
        }else{
            glucoseLabel.text = (sortedData[secion][row].bloodGlucoseMg != nil) ? String(sortedData[secion][row].bloodGlucoseMg!):"-"
        }
        // 事件
        eventLabel.text = (sortedData[secion][row].eatType != nil) ? String(sortedData[secion][row].eatType!):"-"
        // 进餐量
        appetiteLabel.text = (sortedData[secion][row].eatNum != nil) ? String(sortedData[secion][row].eatNum!):"-"
        
        // 先判断有没有胰岛素量，若没有再判断有没有胰岛素类型
        // 胰岛素类型和量
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
        weightLabel.text = (sortedData[secion][row].weightKg != nil) ? String(sortedData[secion][row].weightKg!):"-"
        // 血压
        if GetUnit.getPressureUnit() == "mmHg"{
            bloodPressureLabel.text = (sortedData[secion][row].systolicPressureMmhg != nil) ? String(sortedData[secion][row].systolicPressureMmhg!) + "/" + String(sortedData[secion][row].diastolicPressureMmhg!):"-"
        }else{
            bloodPressureLabel.text = (sortedData[secion][row].systolicPressureKpa != nil) ? String(sortedData[secion][row].systolicPressureKpa!) + "/" + String(sortedData[secion][row].diastolicPressureKpa!):"-"
        }
        // 药物
        medicineLabel.text = sortedData[secion][row].medicine ?? "-"
        
        // 先判断有没有运动量，若没有再判断有没有运动类型
        // 运动
        if sortedData[secion][row].sportTime != nil{
            sportLabel.text = String(sortedData[secion][row].sportType!) + "\n" + String(sortedData[secion][row].sportTime!)
            sportLabel.font = UIFont.systemFont(ofSize: 10)
        }else if sortedData[secion][row].sportType != nil{
            sportLabel.text = String(sortedData[secion][row].sportType!)
        }
        else{
            sportLabel.text = "-"
        }
        
        if let remarkText = sortedData[secion][row].remark{
            remarkLabel.text = remarkText
        }else{
            remarkLabel.text = "-"
        }
        
        
        let labels:[UILabel] = [glucoseLabel,eventLabel,appetiteLabel,isulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel,remarkLabel]
        
        var offsetX:CGFloat = 0
        for i in labels{
            //i.font = UIFont.systemFont(ofSize: 12)
            i.frame = CGRect(x: offsetX, y: 0, width: 80, height: 40)
            i.textAlignment = .center
            i.numberOfLines = 0
            
            offsetX += 80
            self.addSubview(i)
        }
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
