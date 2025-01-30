//
//  WIMWHomeVC.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import UIKit

class WIMWHomeVC: UIViewController {
    
    let tableView = UITableView()
    private var outages = [Outage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSearchController()
        
        
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Aktif Kesintiler"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Konum arayın"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func getOutages(completion: @escaping([Outage]) -> Void) {
        NetworkManager.shared.getWaterOutages { [weak self] result in
            guard let self = self else {return}
           
            switch result {
            case.success(let outages):
                self.outages = outages
                self.tableView.reloadData()
            case.failure(let error):
                print("Kesinti bilgisi bulunamadı.")
            }
        }
    }


}


extension WIMWHomeVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


extension WIMWHomeVC : UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    

}
