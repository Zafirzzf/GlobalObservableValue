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

extension CacheStorer where T == Bool {
    static let match = CacheStorer<T>()
}

extension CacheStorer where T == String? {
    static let username = CacheStorer<T>()
}
