//
//  LeagueCell.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit

class LeagueCell: UITableViewCell {
    @IBOutlet weak var leagueTitleLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with viewModel: LeagueCellViewModel) {
        leagueTitleLabel.text = viewModel.title
    }
    
}
