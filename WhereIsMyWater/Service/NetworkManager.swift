//
//  NetworkManager.swift
//  WhereIsMyWater
//
//  Created by Aykut Türkyılmaz on 29.01.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let waterOutagesURL = "https://openapi.izmir.bel.tr/api/izsu/arizakaynaklisukesintileri"
    
    
    func getWaterOutages(completion: @escaping(Result<[Outage],Error>) -> Void) {
        
        guard let url = URL(string: waterOutagesURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode([Outage].self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
