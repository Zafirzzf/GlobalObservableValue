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
    
    private var id: String?
    private let initialValue: T.ValueType
    private var storer: T
    
    var wrappedValue: T.ValueType {
        get {
            id.flatMap { storer.cacheMap[$0] } ?? initialValue
        }
        set {
            guard let id = id else { return }
            storer.updateValue(of: id, value: newValue)
        }
    }
    
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    
    init(wrappedValue value: T.ValueType, id: String? = nil, storer: T) {
        self.id = id
        self.storer = storer
        self.initialValue = value
        self.wrappedValue = value
    }
    
    init(wrappedValue value: T.ValueType, storer: T) {
        self.initialValue = value
        self.storer = storer
        self.wrappedValue = value
    }

    mutating func addObserver(_ target: AnyObject, id: String, handler: @escaping (T.ValueType) -> Void) {
        self.id = id
        storer.observe(target, key: id, handler: handler)
    }
}
