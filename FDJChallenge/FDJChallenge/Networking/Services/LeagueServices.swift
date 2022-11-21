//
//  TeamsServices.swift
//  FDJProject
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import Combine

protocol LeagueServicesProtocol: AnyObject {
   static func fetchAllLeagues() -> AnyPublisher<LeagueModel, NetworkError>
    static func fetchTeams(teamName: String) -> AnyPublisher<detailsModel, NetworkError>
    static func fetchTeamDetails(teamName: String) -> AnyPublisher<detailsModel, NetworkError>
}
class LeagueService: LeagueServicesProtocol {
    static func fetchAllLeagues() -> AnyPublisher<LeagueModel, NetworkError> {
        let endpoint = Route.getLeagues
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
    
    static func fetchTeams(teamName: String) -> AnyPublisher<detailsModel, NetworkError> {
        let endpoint = Route.teams(leagueName: teamName)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }
    
    static func fetchTeamDetails(teamName: String) -> AnyPublisher<detailsModel, NetworkError> {
        let endpoint = Route.teamsDetails(teamName: teamName)
        let request = endpoint.createRequest()
        return NativeRequestable.request(request)
    }

}
