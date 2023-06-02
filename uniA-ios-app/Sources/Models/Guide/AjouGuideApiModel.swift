//
//  AjouGuideTableApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/30.
//

import Foundation
import Alamofire

class AjouGuideApiModel {
    
    func callTableList(id: Int, onCompleted: @escaping ([String]) -> Void) {

            let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/guide/title/\(id)"
            let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: encodedStr)!
            let header: HTTPHeaders = ["accept": "*/*"]
            
            AF.request(url, method: .get, parameters: nil, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(response.debugDescription)
                    print("Response: \(value)")
                    if let jsonData = response.data {
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
                            var titles: [String] = []
                            for json in jsonArray ?? [] {
                                if let title = json["titles"] as? String {
                                    titles.append(title)
                                }
                            }
                            onCompleted(titles)
                        } catch {
                            print("JSON decoding error: \(error)")
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data received"])
                        print("Error: \(error)")
                    }
                case .failure(let error):
                    print(response.debugDescription)
                    print("Error: \(error)")
                }
            }
        }
    
    func callTextList(id: Int, onCompleted: @escaping ([String]) -> Void) {

            let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/guide/content/\(id)"
            let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: encodedStr)!
            let header: HTTPHeaders = ["accept": "*/*"]
            
            AF.request(url, method: .get, parameters: nil, headers: header).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(response.debugDescription)
                    print("Response: \(value)")
                    if let jsonData = response.data {
                        do {
                            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
                            var contents: [String] = []
                            for json in jsonArray ?? [] {
                                if let content = json["contents"] as? String {
                                    contents.append(content)
                                }
                            }
                            onCompleted(contents)
                        } catch {
                            print("JSON decoding error: \(error)")
                        }
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid data received"])
                        print("Error: \(error)")
                    }
                case .failure(let error):
                    print(response.debugDescription)
                    print("Error: \(error)")
                }
            }
        }
    
}
