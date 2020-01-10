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
    
    func observe(_ target: AnyObject, key: Key, handler: @escaping (ValueType) -> Void) {
        observable.subscribe(target) { (dict) in
            if let value = dict[key] {
                handler(value)
            }
        }
    }
}

class CacheStorer<T>: MemoryCacheStorerProtocol {
    deinit {
        print("cacheStorer销毁")
    }
    typealias ValueType = T
    var cacheMap: [String : T] = [:]
    var observable = AHObservable<[String : T]>(nil)
}

final class MatchCacheStorer: CacheStorer<Bool> {
    static let shared = MatchCacheStorer()
}

final class UserNameCacheStorer: CacheStorer<String?> {
    static let shared = UserNameCacheStorer()
}
