//
//  AppRankModel.swift
//  iAppStore
//
//  Created by Thanos_Liu on 2022/11/29.
//  Copyright © 2022 liuyisi. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class AppRankModel: ObservableObject {

    @Published var results: [Results] = []
    
    @Published var alertMsg: String = ""
    @Published var isShowAlert: Bool = false
    private var cancelable = Set<AnyCancellable>()
    
    @Published var isLoading: Bool = false
    
    init() {
        self.addSubscriber()
    }
    
    private func addSubscriber() {
        NetworkStateChecker.shared.publisher
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { _ in
                //
            } receiveValue: { path in
                switch path.status {
                case .satisfied:
                    self.isShowAlert = false
                    print("network satisfied.")
                case .unsatisfied:
                    self.isShowAlert = true
                    self.alertMsg = "Network unconnected."
                    print("network unsatisfied.")
                case .requiresConnection:
                    self.isShowAlert = true
                    self.alertMsg = "Network require connection."
                    print("network require connection.")
                @unknown default:
                    fatalError()
                }
            }
            .store(in: &cancelable)
    }
    
    func fetchRankData(_ limit: Int64) {
        
        var endpoint: APIService.Endpoint
        
        endpoint = APIService.Endpoint.topFreeApplications(limit: limit)

        isLoading = true
        
        print("endpoint-----",endpoint)
        
        APIService.shared.POST(endpoint: endpoint, params: nil) { (result: Result<AppResult, APIService.APIError>) in
            
            self.isLoading = false
            
            switch result {
            case let .success(response):
                self.results = response.results
            case .failure(let error):
                print("api reqeust erro: \(error)")
                self.isShowAlert = true
                self.alertMsg = "\(error)";
                break
            }
        }
        
    }

}
