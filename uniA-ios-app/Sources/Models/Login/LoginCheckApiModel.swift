//
//  LoginCheckModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/04.
//

import Foundation
import Alamofire

class LoginCheckApiModel {

    func checkSuccess(onCompleted : @escaping(CreateAccount)-> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/member/login/success"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    
    func checkFail(onCompleted : @escaping(CreateAccount)-> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/member/login/fail"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        
        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
}
