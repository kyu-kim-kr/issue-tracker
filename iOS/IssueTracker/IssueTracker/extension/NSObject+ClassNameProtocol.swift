//
//  NSObject+ClassNameProtocol.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/08.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

