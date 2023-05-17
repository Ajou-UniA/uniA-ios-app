//
//  TaskResponse.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/17.
//

import Foundation

// MARK: - Task Response
struct TaskResponse: Codable {
    let assignmentId: Int
    let deadline: Date
    let lectureName: String
    let name: String
    let description: String
    let dayLeftText: String

    init(assignmentId: Int, deadline: Date, lectureName: String, name: String, description: String, dayLeftText: String) {
        self.assignmentId = assignmentId
        self.deadline = deadline
        self.lectureName = lectureName
        self.name = name
        self.description = description
        self.dayLeftText = dayLeftText
    }

    enum CodingKeys: String, CodingKey {
        case assignmentId, deadline, lectureName, name, description, dayLeftText
    }
}

