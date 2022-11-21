//
//  TeamViwModel.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import Combine
class TeamViewModel {
    
enum State {
    case initial
    case loading
    case success([TeamItem])
    case fail(Error)
}
    var league: LeaugeItem
    var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state = State.initial
    
    init(
     league: LeaugeItem
    ) {
        self.league = league

    }
         
    func getList()  {
        LeagueService
            .fetchTeams(teamName: league.strLeague)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let `self` = self else { return }
                switch completion {
                case .failure(let error):
                    self.state = .fail(error)
                case .finished:
                    print("nothing much to do here")
                }
            } receiveValue: { (response) in
                debugPrint(response)
                self.state = .success(response.teams)
            }
            .store(in: &subscriptions)

    }
}

