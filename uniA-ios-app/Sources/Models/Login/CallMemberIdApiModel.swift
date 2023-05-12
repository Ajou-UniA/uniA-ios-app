//
//  CallMemberIdApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/05/12.
//

import Foundation
import Alamofire

class CallMemberApiModel {

    func callMember(email: String, onCompleted: @escaping(Data) -> Void) {
        let urlSTR = "http://ec2-52-79-76-213.ap-northeast-2.compute.amazonaws.com:8080/api/v1/email-check/\(email)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept": "*/*"]
        
        AF.request(url, method: .get, parameters: nil, headers: header).validate().responseData { response in
              switch response.result {
              case .success(let value):
                  print(response.debugDescription)
                  print("Response: \(value)")
                  onCompleted(value)
              case .failure(let error):
                  print(response.debugDescription)
                  print("Error: \(error)")

              }
          }
        }
}
