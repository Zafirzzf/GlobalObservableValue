//
//  ObservableValue.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/5.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

@propertyWrapper
struct MemoryObservableValue<T: MemoryCacheStorerProtocol> {
    
    private var key: String?
    private let initialValue: T.ValueType
    private var storer: T
    
    var wrappedValue: T.ValueType {
        get {
            key.flatMap { storer.cacheMap[$0] } ?? initialValue
        }
        set {
            guard let id = key else { return }
            storer.updateValue(of: id, value: newValue)
        }
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    init(wrappedValue value: T.ValueType, key: String?, storer: T) {
        self.key = key
        self.storer = storer
        self.initialValue = value
        self.wrappedValue = value
    }
    
    init(wrappedValue value: T.ValueType, storer: T) {
        self.initialValue = value
        self.storer = storer
        self.wrappedValue = value
    }
    
    mutating func setObserverKey(_ key: String) {
        self.key = key
    }

    mutating func addObserver(_ target: AnyObject, handler: @escaping (T.ValueType) -> Void) {
        guard let key = key else {
            return
        }
        storer.observe(target) { (dict) in
            guard let value = dict[key] else {
                return
            }
            handler(value)
        }
    }
}
