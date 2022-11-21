//
//  LeagueFactory.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import UIKit

final class LeagueFactory {
    static func configureView( ) -> LeagueViewController {
        let viewModel = LeagueViewModel()
        return LeagueViewController
            .init(viewModel: viewModel)
    }
}
