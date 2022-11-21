//
//  HomeViewController.swift
//  FDJChallenge
//
//  Created by Devinsley on 16/11/2022.
//

import UIKit

enum ViewsInContainer {
    case league
    case team
}

class HomeViewController: UIViewController {
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var containerView: UIView!
    
    let startStep: ViewsInContainer = .league
    var indexCurrentVC = 0
    var leagueVC: LeagueViewController?
    var teamVC: TeamViewController?
    var homeSubviews: [UIViewController] = []

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSubviewsInContainers()
        if let navigationVC = self.children.first as? UINavigationController {
            navigationVC.viewControllers = homeSubviews
        }
        showNextViewControlelr(index: indexCurrentVC)
        setUpSearchBar()
    }
    
    func setUpToLeague() {
        if let teamVC = teamVC , homeSubviews.contains(teamVC) {
            homeSubviews.removeLast()
        }
        self.indexCurrentVC = 0
    }
    
    func setupToTeam() {
        self.indexCurrentVC = 1
    }
    
    func setUpSearchBar() {
        searchField.delegate = self
        containerView.isHidden = true
        
    }
    func prepareSubviewsInContainers () {
        leagueVC = LeagueFactory.configureView()
        leagueVC?.delegate = self
        guard let leagueVC = leagueVC else { return }
        self.homeSubviews.append(leagueVC)
    }
    
    func showNextViewControlelr (index: Int) {
        // remove old VC
        self.children.forEach {
            $0.didMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
        // show new VC
        if let newVC = homeSubviews[index] as? UIViewController {
            addChild(newVC)
            containerView.addSubview(newVC.view)
            newVC.view.frame = containerView.bounds
            newVC.didMove(toParent: self)
        }
    }
}



extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        containerView.isHidden = searchText.isEmpty ? true : false
        if homeSubviews[indexCurrentVC] == leagueVC {
            leagueVC?.filterArrayBy(sub: searchText)
        }
        if searchText.isEmpty {
            HideLayouts()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.searchTextField.resignFirstResponder()
        HideLayouts()
        containerView.isHidden = (searchBar.text ?? "").isEmpty ? true : false
        
    }
    
    private func HideLayouts() {
      setUpToLeague()
        showNextViewControlelr(index: indexCurrentVC)
    }
}


extension HomeViewController: LeagueTeamDelegates {
    func showTeamDetails(from team: TeamItem) {
        self.navigationController?.pushViewController(DetailsFactory.configureView(from: team), animated: true)
    }
    
    func showTeams(from league: LeaugeItem) {
        self.teamVC = TeamFactory.configureView(from: league)
        teamVC?.delegate = self
        guard  let teamVC = teamVC else { return }
        self.homeSubviews.append(teamVC)
        setupToTeam()
        showNextViewControlelr(index: indexCurrentVC)
    }
    
    
}
