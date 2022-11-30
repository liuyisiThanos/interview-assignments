//
//  iAppStoreApp.swift
//  iAppStore
//
//  Created by Thanos_Liu on 2022/11/29.
//  Copyright © 2022 liuyisi. All rights reserved.
//

import SwiftUI

@main
struct iAppStoreApp: App {
    
    @StateObject var storeApp = StoreListViewModel()
    
    init() {
        setupApperance()
    }
    
    var body: some Scene {
        WindowGroup {
            AppHome()
        }
    }
    
    private func setupApperance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black]
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ], for: .normal)
        
        UIWindow.appearance().tintColor = UIColor.black
    }
}




