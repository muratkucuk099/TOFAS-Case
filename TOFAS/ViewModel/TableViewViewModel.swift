//
//  TableViewViewModel.swift
//  TOFAS
//
//  Created by Mac on 24.01.2024.
//

import Foundation

class TableViewViewModel {
    var list = [PostModel]()
    
    func getListData(completionHandler: @escaping (Bool) -> Void) {
        APICall.apiCall.getPosts() { result in
            self.list = result
            completionHandler(true)
        }
    }
    
    func getOnePost(indexpath: Int) -> PostModel {
        return list[indexpath]
    }
    
    func getCount() -> Int {
        return list.count
    }
}
