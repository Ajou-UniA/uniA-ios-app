//
//  EditMyProfileApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class EditMyProfileApiModel {

    let baseURL = Const.URL.baseURL

    func editProfile(memberId: Int, bodyData: Parameters, onCompleted: @escaping(Profile) -> Void) {
        
        let url = "\(baseURL)member/update/\(memberId)"
        
        let headers: HTTPHeaders = ["accept": "*/*","Content-Type": "application/json"]
          
        AF.request(url, method: .patch, parameters: bodyData, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseDecodable(of: Profile.self) { response in
                switch response.result {
                case .success(let profile):
                    print("PATCH request succeeded")
                    onCompleted(profile)
                
                case .failure(let error):
                    print("PATCH request failed with error: \(error)")
                }
            }
    }
}
