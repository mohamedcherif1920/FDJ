//
//  LeaguesViewModel.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import Foundation
import Combine

protocol LeagueViewModelProtocol {
    func getList()
}
class LeagueViewModel: LeagueViewModelProtocol, ObservableObject {
    
    enum State {
        case initial
        case loading
        case success([LeaugeItem])
        case fail(Error)
        
    }
    var subscriptions = Set<AnyCancellable>()
    @Published private(set) var state = State.initial
    
    func getList()  {
        LeagueService
            .fetchAllLeagues()
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
                self.state = .success(response.leagues)
            }
            .store(in: &subscriptions)
    }
}


