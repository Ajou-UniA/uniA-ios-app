//
//  SignInApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/04.
//

import Foundation
import Alamofire

class SignInApiModel {
    
    var urlString: String?
    
    func requestSignInDataModel(bodyData: Parameters, onCompleted: @escaping(CreateAccount) -> Void) {

        urlString = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/member/login"
        
        guard let urlString = urlString else { return}
        guard let url = URL(string: urlString) else {return print("error")}
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        AF.request(url, method: .post, parameters: bodyData, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseData { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let value):
                    UserDefaults.standard.set(true, forKey: "loginSuccess")
                    print("Success: \(value)")
                    
                case .failure(let error):
                    UserDefaults.standard.set(false, forKey: "loginSuccess")
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    
}
