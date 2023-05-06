//
//  Profile.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/07.
//

import Foundation

// MARK: - Profile
struct Profile: Codable {
    let firstName, lastName, memberEmail: String?
    let memberId: Int?
    let memberMajor: String?

}
