//
//  NetworkManager.swift
//  CatsApp
//
//  Created by Juan Ernesto Crawford Naranjo on 17/5/24.
//

import Alamofire
import Foundation
import Combine

/// A manager responsible for fetching cat data from an API.
class NetworkManager: ObservableObject {
    /// The array of cats fetched from the API.
    @Published var cats = [Cat]()
    /// A boolean value indicating whether data is currently being loaded.
    @Published var isLoading = false
    /// A boolean value indicating whether more data is currently being loaded.
    @Published var isLoadingPage = false
    /// The current page number for pagination.
    private var currentPage = 0
    /// A boolean value indicating whether more pages can be loaded.
    private var canLoadMorePages = true
    /// The API key for accessing the cat API.
    private let api_key = "live_yOs5YsznTrkcYBfckg2m9OnIENkJC0QJvgDCwmuNuGT7VYrXZpxhHVs1xS6xYiC3"
    /// The base URL for the cat API.
    private let api_url_base = "https://api.thecatapi.com/v1/"
    
    /// Initializes a new instance of `NetworkManager`.
    init() {
        isLoading = true
        getCats()
    }
    
    /// Fetches more cat data if needed based on the current item.
    /// - Parameter item: The current cat item being displayed.
    func getCatsIfNeeded(currentItem item: Cat?) {
        guard let item = item else {
            getCats()
            return
        }
        let thresholdIndex = cats.index(cats.endIndex, offsetBy: -5)
        if cats.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            getCats()
        }
    }
    
    /// Fetches cat data from the API.
    private func getCats() {
        guard !isLoadingPage && canLoadMorePages else {
            return
        }
        isLoadingPage = true
        let pageSize = 10
        let parameters: [String: Any] = [
            "page": currentPage,
            "limit": pageSize,
            "has_breeds": 1,
            "api_key": api_key
        ]
        AF.request("\(api_url_base)images/search", parameters: parameters)
            .validate()
            .responseDecodable(of: [Cat].self) { response in
                switch response.result {
                case .success(let cats):
                    self.canLoadMorePages = cats.count >= pageSize
                    self.currentPage += 1
                    self.cats += cats
                    self.isLoading = false
                    self.isLoadingPage = false
                case .failure(let error):
                    print(error)
                    self.isLoading = false
                    self.isLoadingPage = false
                }
            }
    }
}
