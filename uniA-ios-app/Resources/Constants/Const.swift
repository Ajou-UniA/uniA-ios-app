//
//  Const.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/04.
//

import Foundation

struct Const {
    static let accessToken: String = UserDefaults.standard.string(forKey: Const.UserDefaultsKey.accessToken) ?? ""
    static let id: String  = "userID@ajou.ac.kr"
    static let pw: String = "password"
}
