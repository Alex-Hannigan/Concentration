//
//  Card.swift
//  Concentration
//
//  Created by Alex Hannigan on 2017/11/14.
//  Copyright © 2017年 Alex Hannigan. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
