//
//  CreateAccount.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/06.
//

import Foundation

// MARK: - CreateAccount
struct CreateAccount: Codable {
    let body: Body?
    let statusCode: String?
    let statusCodeValue: Int?
}

// MARK: - Body
struct Body: Codable {
}
