//
//  AHObservable.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/3.
//  Copyright © 2020 周正飞. All rights reserved.
//

import Foundation

class AHObservable<T> {
    
    private var value: T?
    private var observers: Set<AHObserverHandler<T>> = []
    
    init(_ value: T?) {
        self.value = value
    }
    
    func on(_ new: T) {
        for observer in observers {
            if observer.target != nil {
                observer.action(new)
            } else {
                observers.remove(observer)
            }
        }
    }
    
    func subscribe(_ target: AnyObject, action: @escaping (T) -> Void) {
        let handler = AHObserverHandler(target: target, action: action)
        // 重复注册, 保留后一个
        if observers.contains(handler){
            observers.remove(handler)
        }
        observers.insert(handler)
    }
}

class AHObserverHandler<T>: Hashable {

    let action: (T) -> Void
    weak var target: AnyObject?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(target?.hash)
    }
    
    static func == (lhs: AHObserverHandler<T>, rhs: AHObserverHandler<T>) -> Bool {
        return lhs === rhs
    }
    
    init(target: AnyObject?, action: @escaping (T) -> Void) {
        self.target = target
        self.action = action
    }
}
