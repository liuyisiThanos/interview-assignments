//
//  AppRank.swift
//  iAppStore
//
//  Created by Thanos_Liu on 2022/11/29.
//  Copyright © 2022 liuyisi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - AppRankM
struct AppResult: Codable {
    let resultCount: Int64
    let results: [Results]
}

// MARK: - Feed
struct Results: Codable {
    let isGameCenterEnabled: Bool
    let artworkUrl512: String
    let artworkUrl100: String
    let artistViewUrl: String
    let kind: String
    let currentVersionReleaseDate: String
    let artistName: String
    let primaryGenreName: String
    let trackName: String
    let trackId: Int64
    let description: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let releaseNotes: String
}

