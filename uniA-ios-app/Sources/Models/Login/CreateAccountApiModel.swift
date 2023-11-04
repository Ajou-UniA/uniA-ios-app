//
//  SignUpApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/13.
//

import Foundation
import Alamofire

class CreateAccountApiModel {
    
    var urlString: String?
    let baseURL = Const.URL.baseURL
    
    func requestSignUpDataModel(bodyData: Parameters, onCompleted: @escaping(CreateAccount) -> Void) {

        urlString = "\(baseURL)create"
        
        guard let urlString = urlString else { return}
        guard let url = URL(string: urlString) else {return print("error")}
        let header: HTTPHeaders = ["accept": "*/*", "Content-Type": "application/json"]
        
        AF.request(url, method: .post, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: CreateAccount.self) { response in
            switch response.result {
            case .success(let res):
                print(response.debugDescription)
                onCompleted(res)
            case .failure(let error):
                print(response.debugDescription)
                print(error.localizedDescription)
            }
        }

    }
    
}
