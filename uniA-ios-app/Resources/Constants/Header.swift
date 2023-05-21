//
//  Header.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/03.
//

import Foundation

extension Const {
    struct Header {
        static let loginHeader = ["Content-Type": "application/x-www-form-urlencoded"]
        static var multipartHeader = ["Content-Type": "multipart/form-data"]
        static var header = ["Content-Type": "application/json"]
        static var multiTokenHeader2 = [
          "Content-Type": "multipart/form-data"]
    }
}

