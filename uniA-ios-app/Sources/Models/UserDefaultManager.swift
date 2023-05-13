//
//  UserDefaultManager.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/04/15.
//

//import Foundation
//
//struct User: Codable {
//    var nickName: String
//    var gender: String
//    var id: String
//    var password: String
//    var phoneNumber: String
//    var loverNumber: String?
//    var loverText: String?
//}
//
//struct UserDefaultManager {
//    @UserDefault(key: "user", defaultValue: User(nickName: "", gender: "남자", id: "0", password: "0", phoneNumber: "", loverNumber: nil, loverText: nil))
//    public static var user: User
//}
//
//@propertyWrapper
//struct UserDefault<T: Codable> {
//    private let key: String
//    private let defaultValue: T
//    public let storage: UserDefaults
//
//    init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
//        self.key = key
//        self.defaultValue = defaultValue
//        self.storage = storage
//    }
//
//    var wrappedValue: T {
//        get {
//            guard let data = self.storage.object(forKey: key) as? Data else {
//                return defaultValue
//            }
//
//            let value = try? JSONDecoder().decode(T.self, from: data)
//            return value ?? defaultValue
//        }
//        set {
//            let data = try? JSONEncoder().encode(newValue)
//
//            UserDefaults.standard.set(data, forKey: key)
//        }
//    }
//}
//
//
//
