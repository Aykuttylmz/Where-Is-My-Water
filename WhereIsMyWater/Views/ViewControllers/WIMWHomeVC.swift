//
//  WIMWHomeVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import UIKit

class WIMWHomeVC: UIViewController {
    
    let tableView = UITableView()
    var outages = [Outage]()
    var filteredOutages = [Outage]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
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
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
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
                    self.tableView.reloadData()
                }
            case.failure(let error):
                let alert = UIAlertController(title: "Error", message: error.localizedDescription,preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    
    func updateDate(on outages: [Outage]) {
        
    }
}


extension WIMWHomeVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WIMWOutageCell.reuseID, for: indexPath) as! WIMWOutageCell
        let outage = outages[indexPath.row]
        cell.set(outage: outage)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let outage = outages[indexPath.row]
        let destVC = WIMWOutageDetailVC(outage: outage)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
}


extension WIMWHomeVC : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        isSearching = true
        filteredOutages = outages.filter({ $0.Mahalleler.lowercased().contains(filter.lowercased())})
        
        
        
        
        
    }
    

}
