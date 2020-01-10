//
//  User.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/3.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

class UserRelation {
    var alohaGet: Bool = false
    
    @MemoryObservableValue(storer: MatchCacheStorer.shared)
    var match: Bool = false
    
    @MemoryObservableValue(storer: UserNameCacheStorer.shared)
    var name: String? = nil
    
    var userId = ""
    
    init(id: String) {
        self.userId = id
        self.match = false
    }
}
