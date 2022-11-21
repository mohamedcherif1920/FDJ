//
//  EndPoints.swift
//  FDJProject
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
public enum EndPoints {
    /// cases
    case league
    case team
    case details

    /// variable path qui retourne l'url a utiliser
    var path: String {
        switch self {
        case .league: return  "/all_leagues.php"
        case .team: return "/search_all_teams.php?l="
        case .details: return "/searchteams.php?t="
        }
    }
}
/// concatination a l'url de base
extension EndPoints: CustomStringConvertible {
    public var description: String { return AppConfiguration.baseUrl.appending(path)  }
}

enum FetchError: Error {
    case failed
    case timeout
    case permission(String)
}
