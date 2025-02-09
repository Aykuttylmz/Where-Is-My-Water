//
//  WIMWHomeVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import UIKit

class WIMWHomeVC: UIViewController {
    
    
    enum Section {
        case main
    }
    
    
    let tableView = UITableView()
    var outages: [Outage] = []
    var filteredOutages: [Outage] = []
    var isSearching = false
    var dataSource: UITableViewDiffableDataSource<Section, Outage>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureDataSource()
        configureSearchController()
        
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
        NetworkManager.shared.getWaterOutages { [weak self] result in
            guard let self = self else {return}
           
            switch result {
            case.success(let outages):
                DispatchQueue.main.async {
                    self.outages = outages
                    self.updateData(on: outages)
                }
            case.failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func updateData(on outages: [Outage]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Outage>()
        snapshot.appendSections([.main])
        snapshot.appendItems(outages)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot,animatingDifferences: true)
        }
    }
}


extension WIMWHomeVC: UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let outage = dataSource.itemIdentifier(for: indexPath) else {return}
        let destVC = WIMWOutageDetailVC(outage: outage)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension WIMWHomeVC : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        isSearching = true
        filteredOutages = outages.filter({ $0.Mahalleler.lowercased().contains(query.lowercased())})
        updateData(on: filteredOutages)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        //updateData(on: outages)
        getOutages()
    }
    

}
