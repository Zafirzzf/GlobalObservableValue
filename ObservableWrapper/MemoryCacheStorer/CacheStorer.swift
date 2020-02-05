//
//  CacheStorer.swift
//  MemoryCacheStorer
//
//  Created by 周正飞 on 2020/1/16.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

class CacheStorer<T>: MemoryCacheStorerProtocol {
    typealias ValueType = T
    var cacheMap: [String : T] = [:]
    var observable = AHObservable<[String : T]>(nil)
}

struct MemoryCacheStorerConfig {
    static let match = CacheStorer<Bool>()
    static let username = CacheStorer<String?>()
    static let age = CacheStorer<Int>()
}

