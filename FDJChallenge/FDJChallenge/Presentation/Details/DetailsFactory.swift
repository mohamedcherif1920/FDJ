//
//  DetailsFactory.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import UIKit

final class DetailsFactory {
    static func configureView(
        from item: TeamItem
    ) -> DetailsViewController {
        let viewModel = DetailsViewModel(
            team: item
        )
        return DetailsViewController
            .init(viewModel: viewModel)
    }
}

