//
//  AIDFont.swift
//  AIDetector
//
//  Created by yong on 2025/7/25.
//

import UIKit

class AIDFont{
    
    static func font(_ size:CGFloat) -> UIFont{
        let name = "Montserrat-Regular"
        return .init(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func boldFont(_ size:CGFloat) -> UIFont{
        let name =  "Montserrat-Medium"
        return .init(name: name, size: size) ?? UIFont.monospacedSystemFont(ofSize: size, weight: .bold)
    }
    
    
}

