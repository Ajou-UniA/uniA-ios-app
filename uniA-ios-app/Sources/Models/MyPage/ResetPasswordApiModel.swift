//
//  ResetPasswordApiModel.swift
//  uniA-ios-app
//
//  Created by HA on 2023/04/28.
//
//import Foundation
//import Alamofire
//
//class ResetPasswordApiModel {
//
//    var urlString : String?
//
//    func requestChangeDataModel(header : HTTPHeaders, bodyData : Parameters, onCompleted : @escaping(changePw) -> Void){
//
//        urlString = "http://api.lghtsg.site:8090/users/changeInfo/pw"
//
//        guard let urlString = urlString else{ return }
//        guard let url = URL(string: urlString) else {return print("erorr")}
//
//        AF.request(url, method: .patch, parameters: bodyData, encoding: JSONEncoding(), headers: header).validate().responseDecodable(of: changePw.self){ response in
//            switch response.result {
//            case .success(let response):
//                print("====비밀번호 바꿨음====")
//                onCompleted(response)
//            case .failure(let error):
//                print("====비밀번호 못바꿈====")
//                print(response.debugDescription)
//                print(error.localizedDescription)
//            }
//        }
//
//    }
//
//}
