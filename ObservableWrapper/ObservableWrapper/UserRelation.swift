//
//  User.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/3.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

class UserRelation {
    var aloha: ObservableValue<Bool> {
        .init(value: false, id: userId, observableKey: RelationObservableKey(property: "aloha"))
    }
    
    @GlobalObservableValue(wrappedValue: false,
                           observableKey: RelationObservableKey(property: "alohaGet"))
    var alohaGet: Bool
    
    var match: Bool
    var userId = ""
    
    init(id: String) {
        self.userId = id
        self.match = false
    }
}
