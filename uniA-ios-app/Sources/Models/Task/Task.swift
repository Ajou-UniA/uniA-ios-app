//
//  Task.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/17.
//

import Foundation
import Alamofire
import SwiftyJSON

class Task {

    static let shared = Task()

    func createTask(bodyData: Parameters) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding.default, headers: ["accept": "*/*", "Content-Type": "application/json"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }

    func getAllTask(onCompleted: @escaping([TaskResponse]) -> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo/list"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }

    func getLastAssignmentId(onCompleted: @escaping (Int?) -> Void) {
        let urlStr = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo/list"
        guard let url = URL(string: urlStr) else {
            print("Invalid URL: \(urlStr)")
            onCompleted(nil)
            return
        }
        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success(let value):
                    if let data = value.data(using: .utf8) {
                        do {
                            let json = try JSON(data: data)
                            guard let lastTask = json.arrayValue.last,
                                  let lastAssignmentId = lastTask["assignmentId"].int else {
                                print("Failed to extract last assignment ID from response")
                                onCompleted(nil)
                                return
                            }
                            onCompleted(lastAssignmentId)
                        } catch {
                            print("Error: Failed to parse JSON data - \(error)")
                            onCompleted(nil)
                        }
                    } else {
                        print("Failed to convert response to data")
                        onCompleted(nil)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    onCompleted(nil)
                }
            }
    }

    func deleteTask(assignmentId: Int, onCompleted: @escaping (Bool) -> Void) {

        let urlStr = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo/\(assignmentId)"
        guard let url = URL(string: urlStr) else {
            return print("Error: Invalid URL")
        }

        AF.request(url, method: .delete, headers: ["accept": "*/*"])
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    onCompleted(true)
                case .failure(let error):
                    print("Error: \(error)")
                    onCompleted(false)
                }
            }
    }

    func getMyTask(memberId: Int, onCompleted: @escaping([TaskResponse]) -> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    guard let jsonData = try? JSON(data: value) else {
                        print("Error: Failed to decode JSON data")
                        return
                    }
                    let tasks = jsonData.arrayValue.compactMap { taskJSON -> TaskResponse? in
                        guard let assignmentId = taskJSON["assignmentId"].int,
                              let lectureName = taskJSON["lectureName"].string,
                              let name = taskJSON["name"].string
                        else {
                            print("Unexpected string format")
                            return nil
                        }
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //"yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                        guard let deadlineString = taskJSON["deadline"].string,
                              let deadline = dateFormatter.date(from: deadlineString)
                        else {
                            // API 호출 결과에서 예상하지 못한 형식의 데이터가 반환된 경우
                            print("Unexpected data format")
                            return nil
                        }
                        print(response.debugDescription)
                        let description = taskJSON["description"].string ?? ""
                        let dayLeftText = taskJSON["dayLeftText"].string ?? ""
                        return TaskResponse(assignmentId: assignmentId, deadline: deadline, lectureName: lectureName, name: name, description: description, dayLeftText: dayLeftText)
                    }
                    onCompleted(tasks)
                case .failure(let error):
                    if let afError = error.asAFError, afError.responseCode == 204 {
                        // 만약 서버에서 데이터가 없는 응답을 보낸 경우 (HTTP 204), 빈 배열로 호출 완료 처리
                        onCompleted([])
                    } else {
                        print("Error: \(error)")
                    }
                }
            }
    }

    func updateTask(assignmentId: Int, bodyData: Parameters, onCompleted: @escaping (Bool) -> Void) {
        let urlStr = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/todo/\(assignmentId)"
        guard let url = URL(string: urlStr) else {
            return print("Error: Invalid URL")
        }

        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Content-Type": "application/json"
        ]

        AF.request(url, method: .put, parameters: bodyData, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    onCompleted(true)
                case .failure(let error):
                    print("Error: \(error)")
                    onCompleted(false)
                }
            }
    }
}
