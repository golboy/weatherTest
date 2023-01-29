//
//  ForecastTableViewCell.swift
//  WeatherTest
//
//  Created by Golboy on 29/1/2566 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFc: UIImageView!
    @IBOutlet weak var dateFc: UILabel!
    @IBOutlet weak var tempFc: UILabel!
    @IBOutlet weak var huFc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
