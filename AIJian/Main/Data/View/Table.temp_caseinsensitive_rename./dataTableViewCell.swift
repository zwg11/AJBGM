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
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        glucoseLabel.text = "18"
        
        let labels:[UILabel] = [glucoseLabel,eventLabel,appetiteLabel,isulinLabel,weightLabel,bloodPressureLabel,medicineLabel,sportLabel]
        
        var offsetX:CGFloat = 0
        for i in labels{
            i.frame = CGRect(x: offsetX, y: 0, width: 80, height: 40)
            i.textAlignment = .center
            i.text = "-"
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
