////
////  MyPageSErvice.swift
////  uniA-ios-app
////
////  Created by HA on 2023/05/06.
////
//
//import Foundation
//import Moya
//
//enum MyPageService {
//    case createTask
//    // assignmentID: Int, deadline: String, lectureName: String, name: String
//    case updateTask(taskRequest: TaskRequest)
//    case deleteTask(assignmentId: Int)
//    case getTaskList(memberId: Int)
//    case getTaskListSorted(memberId: Int)
//    case findAllTask
//}
//
//extension MyPageService: TargetType {
//
//    var baseURL: URL {
//        return URL(string: Const.URL.baseURL)!
//    }
//
//    var path: String {
//        switch self {
//        case .createTask:
//            return "/todo"
//        case .updateTask(let assignmentId):
//            return "/todo/\(assignmentId)"
//        case .deleteTask(let assignmentId):
//            return "/todo/\(assignmentId)"
//        case .getTaskList(let memberId):
//            return "/todo/\(memberId)"
//        case .getTaskListSorted(let memberId):
//            return "/todo/\(memberId)/sorted"
//        case .findAllTask:
//            return "/todo/list"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self {
//        case .createTask:
//            return .post
//        case .updateTask:
//            return .put
//        case .deleteTask:
//            return .delete
//        case .getTaskList, .getTaskListSorted, .findAllTask:
//            return .get
//        }
//    }
//
//    // let assignmentID, let deadline, let lectureName, let name
//
//    var task: Task {
//        switch self {
//        case .createTask:
//            return .requestParameters(parameters: ["loginId": Const.id, "password": Const.pw], encoding: JSONEncoding.default)
//
////            return .requestParameters(parameters:
////                                        ["assignmentID": assignmentID,
////                                         "deadline": deadline,
////                                         "lectureName": lectureName,
////                                         "name": name],
////                                      encoding: URLEncoding.httpBody)
//        case .updateTask(let taskRequest):
//            return .requestParameters(parameters:
//                                        ["assignmentID": taskRequest.assignmentID,
//                                         "deadline": taskRequest.deadline,
//                                         "lectureName": taskRequest.lectureName,
//                                         "name": taskRequest.name],
//                                      encoding: URLEncoding.httpBody)
//        case .deleteTask:
//            return .requestPlain
//        case .getTaskList:
//            return .requestPlain
//        case .getTaskListSorted:
//            return .requestPlain
//        case .findAllTask:
//            return .requestPlain
//        }
//    }
//
//    var headers: [String: String]? {
//        switch self {
//        case .createTask:
//            return Const.Header.header
//        case .updateTask:
//          return Const.Header.header
//        case .deleteTask:
//            return Const.Header.header
//        case .getTaskList:
//          return Const.Header.header
//        case .getTaskListSorted:
//          return Const.Header.header
//        case .findAllTask:
//          return Const.Header.header
//        }
//    }
//}
