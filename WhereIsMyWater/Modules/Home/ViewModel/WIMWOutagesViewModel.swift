//
//  WIMWOutagesViewModel.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 9.02.2025.
//

import Foundation
import Combine

protocol WIMWHomeViewModelProtocol {
    var outages: [Outage] { get set }
    var filteredOutages: [Outage] { get set }
    var errorMessage: String { get set }
    func fetchOutages()
    func outage(at index: Int) -> Outage
}

final class WIMWHomeViewModel: ObservableObject, WIMWHomeViewModelProtocol {
    
    private let networkService: NetworkManager
    @Published var outages: [Outage] = []
    @Published var filteredOutages: [Outage] = []
    @Published var errorMessage = ""
    
    
    init(networkService: NetworkManager) {
        self.networkService = networkService
    }
    
    
    func fetchOutages() {
        NetworkManager.shared.getOutages { [weak self] result in
            guard let self = self else {return}
           
            switch result {
            case.success(let outages):
                DispatchQueue.main.async {
                    self.outages = outages
                }
            case.failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    
    func outage(at index: Int) -> Outage {
        outages[index]
    }
    
    
    
}
