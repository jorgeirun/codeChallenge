//
//  MealsTableViewCell.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/10/22.
//

import UIKit

class MealsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mealsImage: UIImageView!
    @IBOutlet weak var mealsTitle: UILabel!
    @IBOutlet weak var mealCellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
