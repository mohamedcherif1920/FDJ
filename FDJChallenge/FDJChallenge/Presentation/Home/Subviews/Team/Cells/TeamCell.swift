//
//  TeamCell.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit

class TeamCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(with viewModel: TeamCellViewModel) {
        cellImage.downloadImage(from: viewModel.image)
    }    
}
