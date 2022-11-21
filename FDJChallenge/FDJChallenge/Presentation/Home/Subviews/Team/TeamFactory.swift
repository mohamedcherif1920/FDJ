//
//  TeamFactory.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import UIKit
// MARK: - Factory
final class TeamFactory {
    static func configureView(
        from item: LeaugeItem
    ) -> TeamViewController {
        let viewModel = TeamViewModel(
            league: item
        )
        return TeamViewController
            .init(viewModel: viewModel)
    }
}
