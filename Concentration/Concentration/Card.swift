//
//  Card.swift
//  Concentration
//
//  Created by Admin on 21.02.2019.
//  Copyright © 2019 Remza. All rights reserved.
//

import Foundation
struct Card:Hashable
{
    var hashValue: Int { return identifier}
    var isFaceUp = false
    var isMatched = false
    private var  identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func ==(lhs: Card, rhs: Card)-> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
