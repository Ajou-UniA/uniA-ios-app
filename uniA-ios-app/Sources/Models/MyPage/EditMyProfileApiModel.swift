//
//  EditMyProfileApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class EditMyProfileApiModel {
    
    func findByMemberId(onCompleted: @escaping(Profile) -> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/member/123123123"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        
        AF.request(url, method: .get, headers: ["Content-Type": "application/x-www-form-urlencoded"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(response.debugDescription)
                    print("Success: \(value)")
                    if let data = response.data {
                        do {
                            let profile = try JSONDecoder().decode(Profile.self, from: data)
                                onCompleted(profile)
                                } catch {
                                    print("Error decoding profile data: \(error)")
                                }
                            }
                case .failure(let error):
                    print(response.debugDescription)
                    print("Error: \(error)")
                }
            }
        }
}
