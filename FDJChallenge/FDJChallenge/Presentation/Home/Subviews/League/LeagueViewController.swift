//
//  LeagueViewController.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit
import Combine

class LeagueViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: LeagueViewModel
    private var subscriptions = Set<AnyCancellable>()
    var leagueData: [LeaugeItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var leagueOriginalData: [LeaugeItem] = []
    
    weak var delegate: LeagueDelegate?
    
    init(viewModel: LeagueViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
        .store(in: &subscriptions)
        
        viewModel.getList()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: CellIdentifiers.cellId, bundle: nil),
                           forCellReuseIdentifier: CellIdentifiers.tableViewCellId)
    }
        
    private func render(_ state: LeagueViewModel.State) {
        switch state {
        case .loading, .initial:
            debugPrint("loading")
        case .fail:
            debugPrint("error")
        case .success(let dataResponse):
            leagueData = dataResponse
            leagueOriginalData = dataResponse
        }
    }
    
    func filterArrayBy(sub: String) {
        leagueData =  sub.isEmpty ? leagueOriginalData : leagueOriginalData.filter({$0.strLeague.contains(sub)})
    }
    
}


extension LeagueViewController: TableViewDelegates {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.tableViewCellId, for: indexPath) as? LeagueCell
        let viewModel = LeagueCellViewModel(title: leagueData[indexPath.row].strLeague)
        cell?.update(with: viewModel)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.showTeams(from: leagueData[indexPath.row])
        }
    }    
}
