//
//  DetailsViewController.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    let viewModel: DetailsViewModel
    var teamData: [TeamItem] = [] {
        didSet {
            self.detailTableView.reloadData()
        }
    }
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
        .store(in: &subscriptions)
        viewModel.getList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func render(
        _ state: DetailsViewModel.State
    ) {
        switch state {
        case .loading, .initial:
            debugPrint("loading")
        case .fail:
            debugPrint("error")
        case .success(let dataResponse):
            teamData = dataResponse
        }
    }
    
    private func setupTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: CellIdentifiers.detailId, bundle: nil),
                                 forCellReuseIdentifier: CellIdentifiers.detailsCellId)
        detailTableView.estimatedRowHeight = 120
        detailTableView.rowHeight = UITableView.automaticDimension
    }
}

extension DetailsViewController: TableViewDelegates {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.detailsCellId, for: indexPath) as? DetailsCell
        let viewModel = DetailsCellViewModel(imageBanner: teamData[indexPath.row].strTeamBanner ?? "", country: teamData[indexPath.row].strCountry ?? "", league: teamData[indexPath.row].strLeague ?? "", descrption: teamData[indexPath.row].strDescriptionEN ?? "")
        cell?.update(with: viewModel)
        return cell ?? UITableViewCell()
    }
}

