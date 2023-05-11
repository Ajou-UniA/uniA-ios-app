//
//  ResetPasswordApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class ResetPasswordApiModel {

    func findByMemberId(newPassword: String, memberId: Int, onCompleted: @escaping(Profile) -> Void) {
        
        let url = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/member/\(memberId)"
        let parameters: [String: Any] = ["newPassword": newPassword]
        
        AF.request(url, method: .patch, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    print("PATCH request succeeded")
                case .failure(let error):
                    print("PATCH request failed with error: \(error)")
                }
            }
    }

}
