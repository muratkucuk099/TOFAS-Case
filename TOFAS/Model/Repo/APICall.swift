//
//  APICall.swift
//  TOFAS
//
//  Created by Mac on 24.01.2024.
//

import Foundation
import Alamofire

final class APICall {
    static let apiCall = APICall()
    let url = URL(string: "http://jsonplaceholder.typicode.com/posts")
    
    func getPosts(completionHandler: @escaping ([PostModel]) -> Void) {
        AF.request(url!, method: .get).response { response in
            if let data = response.data {
                do{
                    let posts = try JSONDecoder().decode([PostModel].self, from: data)
                    completionHandler(posts)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}
