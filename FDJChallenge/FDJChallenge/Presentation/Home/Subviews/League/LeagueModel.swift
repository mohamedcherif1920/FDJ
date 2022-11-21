//
//  AllLeaguesResponse.swift
//  FDJProject
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
// MARK: - AllLeaugesResponse
struct LeagueModel: Codable {
    let leagues: [LeaugeItem]
    
    enum CodingKeys: String, CodingKey {
        case leagues
    }
}

// MARK: - Leauge
struct LeaugeItem: Codable {
    let strLeague: String
    let idLeague: String
    
    enum CodingKeys: String, CodingKey {
        case strLeague,idLeague
    }
}
