////
////  MyPageApi.swift
////  uniA-ios-app
////
////  Created by HA on 2023/05/06.
////
//
//import Foundation
//import Moya
//
//public class TaskAPI {
//
//    static let shared = TaskAPI()
//    var myPageProvider = MoyaProvider<MyPageService>()
//
//    public init() {}
//
//    // MARK: - 과제 생성
//    func createTask(taskRequest: TaskRequest, completion: @escaping(NetworkResult<Any>) -> Void) {
//        taskProvider.request(.createTask) { (result) in
//            switch result {
//            case .success(let response):
//                let statusCode = response.statusCode
//                let data = response.data
//                print(response)
//                let networkResult = self.judgeTaskStatus(by: statusCode, data)
//                completion(networkResult)
//            case .failure(let err):
//                print(err)
//            }
//        }
//    }
//
//    func findAllTask(completion: @escaping(NetworkResult<Any>) -> Void) {
//        taskProvider.request(.findAllTask) { (result) in
//            switch result {
//            case .success(let response):
//                let statusCode = response.statusCode
//                let data = response.data
//                print(response)
//                let networkResult = self.judgeAllTaskRecordsStatus(by: statusCode, data)
//                completion(networkResult)
//            case .failure(let err):
//                print(err)
//            }
//        }
//    }
//
//    private func judgeTaskStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode(GenericResponse<TaskResponse>.self, from: data) else { return .pathError } // ActiveRecord
//        switch statusCode {
//        case 200:
//            return .success(decodedData.data ?? "None-data")
//        case 400..<500:
//            return .requestError(decodedData.resultCode, decodedData.message)
//        case 500:
//            return .serverError
//        default:
//            return .networkFail
//        }
//    }
//
//    private func judgeAllTaskRecordsStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
//        let decoder = JSONDecoder()
//        guard let decodedData = try? decoder.decode(GenericResponse<[TaskResponse]>.self, from: data) else { return .pathError }
//        switch statusCode {
//        case 200:
//            return .success(decodedData.data ?? "None-data")
//        case 400..<500:
//            return .requestError(decodedData.resultCode, decodedData.message)
//        case 500:
//            return .serverError
//        default:
//            return .networkFail
//        }
//    }
//}
