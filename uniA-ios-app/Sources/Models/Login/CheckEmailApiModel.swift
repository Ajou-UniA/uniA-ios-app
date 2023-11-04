//
//  CheckEmailModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/14.
//

import Foundation
import Alamofire

class CheckEmailApiModel {

    let baseURL = Const.URL.baseURL

    func checkEmail(email: String, onCompleted: @escaping(CreateAccount) -> Void) {
        let urlSTR = "\(baseURL)email-check/\(email)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept": "*/*"]
        
        AF.request(url, method: .get, parameters: nil, headers: header).validate().responseData { response in
              switch response.result {
              case .success(let value):
                  print(response.debugDescription)
                  print("Response: \(value)")
                  if let statusCode = response.response?.statusCode {
                      let account = CreateAccount(body: Body(), statusCode: String(statusCode), statusCodeValue: statusCode)
                      onCompleted(account)
                }
              case .failure(let error):
                  print(response.debugDescription)
                  print("Error: \(error)")
                  if let statusCode = response.response?.statusCode {
                      let account = CreateAccount(body: Body(), statusCode: String(statusCode), statusCodeValue: statusCode)
                      onCompleted(account)
                  }
              }
          }
        }
}
