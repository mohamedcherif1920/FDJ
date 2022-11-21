//
//  DetailsViewModel.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import Combine
class DetailsViewModel {
    let team: TeamItem
    var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state = State.initial
    
    init(
        team: TeamItem
    ) {
        self.team = team
    }
        
    enum State {
        case initial
        case loading
        case success([TeamItem])
        case fail(Error)        
    }
    
    func getList()  {
        LeagueService
            .fetchTeamDetails(teamName: team.strTeam)
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
