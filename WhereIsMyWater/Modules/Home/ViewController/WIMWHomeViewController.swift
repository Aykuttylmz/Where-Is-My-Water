//
//  WIMWHomeVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import UIKit
import Combine

class WIMWHomeViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private let tableView = UITableView()
    private var isSearching = false
    private var dataSource: UITableViewDiffableDataSource<Section, Outage>!
    private var viewModel: WIMWHomeViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []

    
    init(viewModel: WIMWHomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureDataSource()
        configureSearchController()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getOutages()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Aktif Kesintiler"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK: Configure data source
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Outage>(tableView: tableView, cellProvider: { tableView, indexPath, outage in
            let cell = tableView.dequeueReusableCell(withIdentifier: WIMWOutageCell.reuseID, for: indexPath) as! WIMWOutageCell
            cell.set(outage: outage)
            return cell
            
        })
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.register(WIMWOutageCell.self, forCellReuseIdentifier: WIMWOutageCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Konum arayın"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func getOutages() {
        viewModel.fetchOutages()
    }
    
    
    func updateData(on outages: [Outage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Outage>()
        snapshot.appendSections([.main])
        snapshot.appendItems(outages)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot,animatingDifferences: true)
        }
    }
    
    
    func setupBindings() {
        (viewModel as? WIMWHomeViewModel)?
            .$outages
            .sink{ [weak self] outages in
                self?.updateData(on: outages)
            }
            .store(in: &cancellables)
    }
}


extension WIMWHomeViewController: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let outage = dataSource.itemIdentifier(for: indexPath) else { return }
        let destVC = WIMWOutageDetailVC(outage: outage)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension WIMWHomeViewController : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let query = searchController.searchBar.text, !query.isEmpty else {
            getOutages()
            return
        }
        
        isSearching = true
        viewModel.filteredOutages = viewModel.outages.filter({ $0.Mahalleler.lowercased().contains(query.lowercased())})
        updateData(on: viewModel.filteredOutages)
        
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        getOutages()
    }
    

}
