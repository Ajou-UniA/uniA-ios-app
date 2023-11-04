//
//  DeleteAccountApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class DeleteAccountApiModel {

    let baseURL = Const.URL.baseURL

    func deleteAccount(memberId: Int, onCompleted: @escaping(CreateAccount) -> Void) {
        let urlSTR = "\(baseURL)member/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept": "*/*"]
       
        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Success: \(value)")
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
