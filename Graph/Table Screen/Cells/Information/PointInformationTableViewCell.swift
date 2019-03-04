//
//  PointInformationTableViewCell.swift
//  Graph
//
//  Created by sarin on 03/03/2019.
//  Copyright © 2019 nikitasarin. All rights reserved.
//

import UIKit

class PointInformationTableViewCell: UITableViewCell {

    @IBOutlet private var xValueLabel: UILabel!
    @IBOutlet private var yValueLabel: UILabel!
    @IBOutlet var indexLabel: UILabel!
    
    var viewmodel: PointInformationViewModel?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        guard let viewmodel = viewmodel else {
            return
        }
        indexLabel.text = "\(viewmodel.index)"
        xValueLabel.text = NSString(format: "%.1f", viewmodel.point.x) as String
        yValueLabel.text = NSString(format: "%.1f", viewmodel.point.y) as String
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }

}
