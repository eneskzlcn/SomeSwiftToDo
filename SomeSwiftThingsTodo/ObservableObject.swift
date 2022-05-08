//
//  ObservableObject.swift
//  SomeSwiftThingsTodo
//
//  Created by Nazif Enes Kızılcin on 8.05.2022.
//

import Foundation

final class ObservableObject<T> {
    var value : T {
        didSet {
            listener?(value)
        }
    }
    var listener : ((T) -> Void)?
    
    init(_ value : T) {
        self.value = value
    }
    func bind(_ listener: @escaping(T)-> Void) {
        listener(self.value)
        self.listener = listener
    }
    
}
