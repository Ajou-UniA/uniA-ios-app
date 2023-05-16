//
//  ForgotPasswordApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/17.
//

import Foundation
import Alamofire

class ForgotPasswordApiModel {

    func forgotPassword(newPassword: String, memberId: Int, onCompleted: @escaping(Profile) -> Void) {
        
        let url = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/resetPassword/\(memberId)"
        let parameters: [String: Any] = ["newPassword": newPassword]
        
        AF.request(url, method: .patch, parameters: parameters)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    print("PATCH request succeeded")
                    let profile = Profile(firstName: nil, lastName: nil, memberEmail: nil, memberId: nil, memberMajor: nil)
                    onCompleted(profile)
                case .failure(let error):
                    print("PATCH request failed with error: \(error)")
                }
            }
    }

}
