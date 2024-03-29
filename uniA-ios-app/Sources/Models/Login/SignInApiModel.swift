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
    let baseURL = Const.URL.baseURL

    func requestSignInDataModel(bodyData: Parameters, onCompleted: @escaping(Int) -> Void) {

        urlString = "\(baseURL)member/login"
        
        guard let urlString = urlString else { return}
        guard let url = URL(string: urlString) else {return print("error")}
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        
        AF.request(url, method: .post, parameters: bodyData, encoding: URLEncoding.default, headers: header)
            .validate()
            .responseData { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let value):
                    print("Success: \(value)")
                    if let data = response.data {
                        do {
                            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                            if let result = json?["result"] as? Int {
                                print("Result: \(result)")
                                onCompleted(result)
                            }
                        } catch {
                            print("Failed to parse response data: \(error)")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    
}
