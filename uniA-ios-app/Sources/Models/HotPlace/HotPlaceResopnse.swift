//
//  HotPlaceResopnse.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/27.
//

import Foundation

// MARK: - HotPlace Response
struct HotPlaceResponse: Codable {
    let directionUrl, distance: String
    var hitCount: Int
    let placeAddress, placeName, roadViewUrl: String
    let description: String?

    init(directionUrl: String, distance: String, hitCount: Int, placeAddress: String, placeName: String, roadViewUrl: String, description: String) {
        self.directionUrl = directionUrl
        self.distance = distance
        self.hitCount = hitCount
        self.placeAddress = placeAddress
        self.placeName = placeName
        self.roadViewUrl = roadViewUrl
        self.description = description
    }

    enum CodingKeys: String, CodingKey {
        case directionUrl, distance, hitCount, placeAddress, placeName, roadViewUrl, description
    }
}
