//
//  Route.swift
//  FDJProject
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
public typealias Headers = [String: String]


// if you wish you can have multiple services like this in a project
enum Route {
    
  // organise all the end points here for clarity
    case getLeagues
    case teams(leagueName: String)
    case teamsDetails(teamName: String)

  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case .getLeagues, .teams, .teamsDetails:
            return .POST
        }
    }
    
  // compose the NetworkRequest
    func createRequest() -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
  // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getLeagues, .teams, .teamsDetails:
            return nil

        }
    }
    
  // compose urls for each request
    func getURL() -> String {
        switch self {
        case .getLeagues:
            return EndPoints.league.description
        case .teams(let leagueName):
            return EndPoints.team.description.appending(leagueName.replacingOccurrences(of: " ", with: "%20"))
        case .teamsDetails(let leagueName):
            return EndPoints.details.description.appending(leagueName.replacingOccurrences(of: " ", with: "%20"))

        }
    }
}

