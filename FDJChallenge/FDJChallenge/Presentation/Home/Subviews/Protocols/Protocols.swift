//
//  Protocols.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit
typealias CollectionViewDelegates = UICollectionViewDelegate & UICollectionViewDataSource
typealias TableViewDelegates = UITableViewDelegate & UITableViewDataSource
typealias LeagueTeamDelegates = LeagueDelegate & TeamDelegate

protocol TeamDelegate: AnyObject {
    func showTeamDetails(from team: TeamItem)
}

protocol LeagueDelegate: AnyObject {
    func showTeams(from league: LeaugeItem)
}
