//
//  AHObservableKey.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/7.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

protocol GlobalObservableKey {
    var classTypeDescription: String { get }
    var property: String { get }

}

extension GlobalObservableKey {
    var key: String {
        classTypeDescription + property
    }
}

class RelationObservableKey: GlobalObservableKey {
    var classTypeDescription = String(describing: UserRelation.self)
    let property: String
    
    init(property: String) {
        self.property = property
    }
}
