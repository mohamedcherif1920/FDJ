//
//  TeamViewController.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit
import Combine

class TeamViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: TeamDelegate?
    let viewModel: TeamViewModel
    var teamData: [TeamItem] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: TeamViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
        .store(in: &subscriptions)
        viewModel.getList()
    }
    
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CellIdentifiers.cvCellId, bundle: nil),
                                forCellWithReuseIdentifier: CellIdentifiers.collectionViewCellId)
    }
    
    
    private func render(
        _ state: TeamViewModel.State
    ) {
        switch state {
        case .loading, .initial:
            debugPrint("loading")
        case .fail:
            debugPrint("error")
        case .success(let dataResponse):
            teamData = dataResponse.shuffled()
        }
    }
}


extension TeamViewController: CollectionViewDelegates {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionViewCellId, for: indexPath) as? TeamCell
        
        let viewModel = TeamCellViewModel(image: teamData[indexPath.row].strTeamBadge)
        cell?.update(with: viewModel)
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.showTeamDetails(from: teamData[indexPath.item])
        }
    }
}
