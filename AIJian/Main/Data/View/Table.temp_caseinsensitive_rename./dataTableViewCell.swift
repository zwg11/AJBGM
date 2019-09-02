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
    
    var weightLabel:UILabel = UILabel()
    var bloodPressureLabel:UILabel = UILabel()
    var medicineLabel: UILabel = UILabel()
    var sportLabel:UILabel = UILabel()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(style: UITableViewCell.CellStyle, reuseIdentifier: String?,secion:Int,row:Int){
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        
        glucoseLabel.text = (sortedData[secion][row].bloodGlucoseMmol != nil) ? String(sortedData[secion][row].bloodGlucoseMmol!):"-"
        eventLabel.text = (sortedData[secion][row].eatType != nil) ? String(sortedData[secion][row].eatType!):"-"
        appetiteLabel.text = (sortedData[secion][row].eatNum != nil) ? String(sortedData[secion][row].eatNum!):"-"
        isulinLabel.text = (sortedData[secion][row].insulinType != nil) ? String(sortedData[secion][row].insulinNum!):"-"
        
        weightLabel.text = (sortedData[secion][row].weightKg != nil) ? String(sortedData[secion][row].weightKg!):"-"
        bloodPressureLabel.text = (sortedData[secion][row].systolicPressureMmhg != nil) ? String(sortedData[secion][row].systolicPressureMmhg!) + "/" + String(sortedData[secion][row].diastolicPressureMmhg!):"-"
        medicineLabel.text = sortedData[secion][row].medicine ?? "-"
        if sortedData[secion][row].sportTime != nil{
            sportLabel.text = String(sortedData[secion][row].sportType!) + "\n" + String(sortedData[secion][row].sportTime!)
            sportLabel.font = UIFont.systemFont(ofSize: 10)
        }else{
            sportLabel.text = "-"
        }
        
        
        let labels:[UILabel] = [glucoseLabel,eventLabel,appetiteLabel,isulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel]
        
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
