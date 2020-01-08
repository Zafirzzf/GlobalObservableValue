//
//  ObservableValue.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/5.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

private class GlobalObservableManager {
    static var cacheMap = [String: Any]()
    static var observable = AHObservable<[String: Any]>(nil)
    
    static func updateValue(of key: String, value: Any) {
        cacheMap[key] = value
        observable.on([key: value])
    }
}

class ObservableValue<T> {
    private let key: String
    private let id: String
    deinit {
        
    }
    var value: T? {
        get {
            GlobalObservableManager.cacheMap[hashMapKey] as? T
        }
        set {
            guard let newValue = newValue else { return }
            GlobalObservableManager.updateValue(of: hashMapKey, value: newValue)
        }
    }
    
    var hashMapKey: String {
        id + key
    }
    
    init(value: T, id: String, observableKey: GlobalObservableKey) {
        self.id = id
        self.key = observableKey.key
        self.value = value
    }

    func addObserver(_ target: AnyObject, handler: @escaping (T) -> Void) {
        GlobalObservableManager.observable.subscribe(target) { [weak self] (dict) in
            guard let self = self else {
                return
            }
            if let value = dict[self.hashMapKey] as? T {
                handler(value)
            }
        }
    }
}

@propertyWrapper
struct GlobalObservableValue<T> {
    private let key: String
    private var id: String?

    var wrappedValue: T? {
        get {
            hashMapKey.flatMap { GlobalObservableManager.cacheMap[$0] as? T }
        }
        set {
            guard let newValue = newValue, let hashMapKey = hashMapKey else { return }
            GlobalObservableManager.updateValue(of: hashMapKey, value: newValue)
        }
    }
    var projectedValue: Self {
        get { self }
        set { self = newValue }
    }
    var hashMapKey: String? {
        id.map { $0 + key }
    }
    
    init(wrappedValue value: T?, id: String? = nil, observableKey: GlobalObservableKey) {
        self.id = id
        self.key = observableKey.key
        self.wrappedValue = value
    }

    mutating func addObserver(_ target: AnyObject, id: String, handler: @escaping (T) -> Void) {
        self.id = id
        GlobalObservableManager.observable.subscribe(target) { [self] (dict) in
            guard let hashMapKey = self.hashMapKey else { return }
            if let value = dict[hashMapKey] as? T {
                handler(value)
            }
        }
    }
}
