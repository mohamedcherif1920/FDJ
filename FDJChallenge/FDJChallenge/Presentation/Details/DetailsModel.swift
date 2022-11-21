//
//  DetailsModel.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
// MARK: - AllTeamsResponse
struct detailsModel: Codable {
    let teams: [TeamItem]
    
    enum CodingKeys: String, CodingKey {
        case teams
        
    }
}

// MARK: - Team
struct TeamItem: Codable {
    let strTeamBadge: String
    let strTeam: String
    let strLeague: String?
    let strDescriptionEN: String?
    let strTeamBanner: String?
    let strCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case strTeamBadge
        case strTeam
        case strLeague
        case strDescriptionEN
        case strTeamBanner
        case strCountry
    }
}
