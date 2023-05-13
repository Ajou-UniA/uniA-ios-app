//
//  CallMemberIdApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/12.
//

import Foundation
import Alamofire

class CallMemberApiModel {

    func callMember(memberEmail: String, onCompleted: @escaping (Int) -> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/reset/\(memberEmail)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept": "*/*"]

        AF.request(url, method: .get, parameters: nil, headers: header)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(response.debugDescription)
                    print("Response: \(value)")
                    if let body = response.value {
                        onCompleted(body as! Int)
                    }
                case .failure(let error):
                    print(response.debugDescription)
                    print("Error: \(error)")
            }
        }
    }
}
