//
//  MemoryCacheProtocol.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/8.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

protocol MemoryCacheStorerProtocol {
    typealias Key = String
    associatedtype ValueType
    var cacheMap: [Key: ValueType] { get set }
    var observable: AHObservable<[Key: ValueType]> { get }
}

extension MemoryCacheStorerProtocol {
    mutating func updateValue(of key: Key, value: ValueType) {
        cacheMap[key] = value
        observable.on([key: value])
    }
    
    func observe(_ target: AnyObject, handler: @escaping ([Key: ValueType]) -> Void) {
        observable.subscribe(target, action: handler)
    }
}


