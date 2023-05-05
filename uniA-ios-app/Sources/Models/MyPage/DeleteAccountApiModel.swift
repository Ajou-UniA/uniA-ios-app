//
//  DeleteAccountApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class DeleteAccountApiModel {
    
    func deleteAccount(memberId: Int, onCompleted : @escaping(CreateAccount)-> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/delete/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept" : "*/*"]
       
        AF.request(url, method: .delete, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseJSON{ response in
            switch response.result {
            case .success(let value):
                print("Success: \(value)")
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
