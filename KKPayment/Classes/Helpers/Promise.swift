//
//  Promise.swift
//  KKPayment
//
//  Created by Spock on 2022/9/13.
//

import Foundation
import PromiseKit

extension Thenable {
    /**
     Wrapper for mapping result quickly.
     */
    func and<U>(_ value: U) -> Promise<(T, U)> {
        map { ($0, value) }
    }

    /**
     Wrapper for mapping result quickly.
     */
    func and<U, R>(_ value: U, resultSelector: @escaping ((T, U) -> R)) -> Promise<R> {
        map { resultSelector($0, value) }
    }
}
