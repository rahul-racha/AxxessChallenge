//
//  Box.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import Foundation

class Box<T> {
    typealias Listner = (T) -> Void
    var listner: Listner?
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listner: Listner?) {
        self.listner = listner
        listner?(value)
    }
}
