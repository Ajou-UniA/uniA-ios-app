//
//  CheckEmailModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/14.
//

import Foundation
import Alamofire

class CheckEmailApiModel {

    func checkEmail(email: String, onCompleted : @escaping(CreateAccount)-> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/email-check/\(email)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept" : "*/*"]
        
        AF.request(url, method: .get, parameters: nil, headers: header).validate().responseData{ response in
              switch response.result {
              case .success(let value):
                  print(response.debugDescription)
                  print("Response: \(value)")
                  let account = CreateAccount(body: Body(), statusCode: "200", statusCodeValue: 200)
                  onCompleted(account)
              case .failure(let error):
                  print(response.debugDescription)
                  print("Error: \(error)")

              }
          }
        }
}
