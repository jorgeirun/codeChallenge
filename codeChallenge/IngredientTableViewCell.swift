//
//  IngredientTableViewCell.swift
//  codeChallenge
//
//  Created by Jorge Irun on 6/11/22.
//

import UIKit

class IngredientTableViewCell:UITableViewCell {

    @IBOutlet weak var ingredientTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
