//
//  VerificationApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/14.
//

import Foundation
import Alamofire

class VerificationApiModel {
    
    var urlString : String?
    
    func requestVerificationDataModel(bodyData : Parameters){

        urlString = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/verify"
        
        guard let urlString = urlString else{ return}
        guard let url = URL(string: urlString) else {return print("error")}
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseData { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let value):
                    // 서버 응답이 성공적으로 수신된 경우 처리할 코드 작성
                    print("Success: \(value)")
                    
                case .failure(let error):
                    // 서버 응답이 실패한 경우 처리할 코드 작성
                    print("Error: \(error.localizedDescription)")
                }
        
        }

    }
    
}
