//
//  LogoutApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/11.
//

import Foundation
import Alamofire

class LogoutApiModel {

    let baseURL = Const.URL.baseURL

    func logout(onCompleted: @escaping(CreateAccount) -> Void) {
        let urlSTR = "\(baseURL)member/logout"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        
        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let account = CreateAccount(body: Body(), statusCode: "200", statusCodeValue: 200)
                    onCompleted(account)
                    print("Success: \(value)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
    }
}
