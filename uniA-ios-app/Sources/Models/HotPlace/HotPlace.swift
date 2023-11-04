//
//  HotPlace.swift
//  uniA-ios-app
//
//  Created by 김사랑 on 2023/05/27.
//

import Foundation
import Alamofire
import SwiftyJSON

class HotPlace {

    static let shared = HotPlace()
    let baseURL = Const.URL.baseURL

    var allRestaurantArr: [String] = []

    func getAllPlace(completion: @escaping ([HotPlaceResponse]) -> Void) {
        let url = "\(baseURL)restaurant/list"

        AF.request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let restaurants = try decoder.decode([HotPlaceResponse].self, from: data)

                            let restaurantNames = restaurants.map { $0.placeName }
                            self.allRestaurantArr = restaurantNames

                            completion(restaurants)
                        } catch {
                            print("Error decoding JSON: \(error)")
                            completion([])
                        }
                    } else {
                        print("Empty response data")
                        completion([])
                    }

                case .failure(let error):
                    print("Request error: \(error)")
                    completion([])
                }
            }
    }

    func getSortedByDistance(onCompleted: @escaping([HotPlaceResponse]) -> Void) {

        let urlSTR = "\(baseURL)restaurant/sorted/distance"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    guard let jsonData = try? JSON(data: value) else {
                        print("Error: Failed to decode JSON data")
                        return
                    }
                    let places = jsonData.arrayValue.compactMap { placeJSON -> HotPlaceResponse? in
                        guard let directionUrl = placeJSON["directionUrl"].string,
                              let distance = placeJSON["distance"].string,
                              let hitCount = placeJSON["hitCount"].int,
                              let placeAddress = placeJSON["placeAddress"].string,
                              let placeName = placeJSON["placeName"].string,
                              let roadViewUrl = placeJSON["roadViewUrl"].string
                        else {
                            print("Unexpected string format")
                            return nil
                        }
                        print(response.debugDescription)
                        let description = placeJSON["description"].string ?? ""
                        return HotPlaceResponse(directionUrl: directionUrl, distance: distance, hitCount: hitCount, placeAddress: placeAddress,
                                                placeName: placeName, roadViewUrl: roadViewUrl, description: description)
                    }
                    onCompleted(places)
                case .failure(let error):
                    if let afError = error.asAFError, afError.responseCode == 204 {
                        // 만약 서버에서 데이터가 없는 응답을 보낸 경우 (HTTP 204), 빈 배열로 호출 완료 처리
                        onCompleted([])
                    } else {
                        print("Error: \(error)")
                    }
                }
            }
    }

    func getSortedByLike(onCompleted: @escaping ([HotPlaceResponse]) -> Void) {
        let urlSTR = "\(baseURL)restaurant/sorted/like"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    guard let jsonData = try? JSON(data: value) else {
                        print("Error: Failed to decode JSON data")
                        return
                    }

                    let places = jsonData.arrayValue.compactMap { placeJSON -> HotPlaceResponse? in
                        // Parsing the required fields
                        guard let directionUrl = placeJSON["directionUrl"].string,
                              let distance = placeJSON["distance"].string,
                              let hitCount = placeJSON["hitCount"].int,
                              let placeAddress = placeJSON["placeAddress"].string,
                              let placeName = placeJSON["placeName"].string,
                              let roadViewUrl = placeJSON["roadViewUrl"].string
                        else {
                            print("Unexpected string format")
                            return nil
                        }

                        let description = placeJSON["description"].string ?? ""
                        return HotPlaceResponse(directionUrl: directionUrl,
                                                distance: distance, hitCount: hitCount, placeAddress: placeAddress, placeName: placeName, roadViewUrl: roadViewUrl, description: description)
                    }

                    onCompleted(places)

                case .failure(let error):
                    if let afError = error.asAFError, afError.responseCode == 204 {
                        // 만약 서버에서 데이터가 없는 응답을 보낸 경우 (HTTP 204), 빈 배열로 호출 완료 처리
                        onCompleted([])
                    } else {
                        print("Error: \(error)")
                    }
                }
            }
    }

    func increaseLike(placeName: String, memberId: Int, onCompleted: @escaping (Bool) -> Void) {

        let urlSTR = "\(baseURL)restaurant/\(placeName)/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .patch, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    onCompleted(true)
                case .failure(let error):
                    print("Error: \(error)")
                    onCompleted(false)
                }
            }
    }

    func decreaseLike(placeName: String, memberId: Int, onCompleted: @escaping (Bool) -> Void) {

        let urlSTR = "\(baseURL)restaurant/\(placeName)/unlike/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .patch, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    onCompleted(true)
                case .failure(let error):
                    print("Error: \(error)")
                    onCompleted(false)
                }
            }
    }

    func getLikedPlace(memberId: Int, onCompleted: @escaping([String]) -> Void) {

        let urlSTR = "\(baseURL)restaurant/memberLikes/\(memberId)"
        let encodedStr = urlSTR.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedStr)!

        AF.request(url, method: .get, headers: ["accept": "*/*"])
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        do {
                            let likes = try JSONDecoder().decode([String].self, from: data)
                            onCompleted(likes)
                        } catch {
                            onCompleted([])
                        }
                    } else {
                        onCompleted([])
                    }

                case .failure:
                    onCompleted([])
                }
            }
    }
}
