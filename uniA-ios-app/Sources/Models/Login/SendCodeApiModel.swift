//
//  SendCodeApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//

import Foundation
import Alamofire

class SendCodeApiModel {
    
    func sendCode(email: String, onCompleted : @escaping(CreateAccount)-> Void) {
        
        let urlSTR = "http://ec2-43-201-47-102.ap-northeast-2.compute.amazonaws.com:8080/api/v1/verify/\(email)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!
        let header: HTTPHeaders = ["accept": "*/*"]
        
        AF.request(url, method: .get, parameters: nil,headers: header).validate().responseData{
            response in
              switch response.result {
              case .success(let value):
                  print(response.debugDescription)
                  print("Response: \(value)")
              case .failure(let error):
                  print(response.debugDescription)
                  print("Error: \(error)")

              }
          }
        }
}
