//
//  LRUReplacementPolicy.swift
//  DIYCache
//
//  Created by Dmitry Bespalov on 25/03/17.
//  Copyright © 2017 Dmitry Bespalov. All rights reserved.
//

import Foundation

/// Replacement policy that discards Least Recently Used items first.
public class LRUReplacementPolicy<KeyType>: ReplacementPolicy<KeyType> where KeyType: Hashable {

    private var age: Int = 0
    var recencies = PriorityQueue<KeyType>()

    override func add(_ key: KeyType, cost: Int) {
        super.add(key, cost: cost)
        age += 1
        recencies.insert(key, priority: age)
    }

    override func removeKey() -> KeyType {
        return recencies.dequeue()
    }

    override public func cacheHit(for key: KeyType) {
        super.cacheHit(for: key)
        age += 1
        recencies.updatePriority(for: key, to: age)
    }

    override public func remove(key: KeyType) {
        super.remove(key: key)
        let _ = recencies.remove(key)
    }

}
