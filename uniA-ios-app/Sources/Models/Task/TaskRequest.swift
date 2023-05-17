//
//  TaskRequest.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/17.
//

import Foundation

// MARK: - Task Request
struct TaskRequest: Codable {
    let assignmentId: Int
    let deadline, lectureName, name: String

    enum CodingKeys: String, CodingKey {
        case assignmentId = "assignmentId"
        case deadline, lectureName, name
    }
}

