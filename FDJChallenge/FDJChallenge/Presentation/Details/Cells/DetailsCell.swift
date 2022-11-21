//
//  DetailsCell.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    @IBOutlet weak var descrptionLbl: UILabel!
    @IBOutlet weak var leagueLbl: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var bannerLogo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func update(with viewModel: DetailsCellViewModel) {
        bannerLogo.downloadImage(from: viewModel.imageBanner)
        leagueLbl.text = viewModel.league
        countryLbl.text = viewModel.country
        descrptionLbl.text = viewModel.descrption
    }
}
