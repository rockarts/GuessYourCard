//
//  card.swift
//  PickACard
//
//  Created by Steven Rockarts on 2019-01-06.
//  Copyright © 2019 Figure4Software. All rights reserved.
//

import Foundation
import UIKit

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Two:
            return "two"
        case .Three:
            return "three"
        case .Four:
            return "four"
        case .Five:
            return "five"
        case .Six:
            return "six"
        case .Seven:
            return "seven"
        case .Eight:
            return "eight"
        case .Nine:
            return "nine"
        case .Ten:
            return "ten"
        case .Jack:
            return "jack"
        case .Queen:
            return "queen"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit {
    case Spades, Hearts, Diamonds, Clubs
    
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
}

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        
            return "\(rank.simpleDescription()) of \(suit.simpleDescription())"
        
    }
    
    func getImage() -> UIImage {
        //2_of_spades
        if(rank.rawValue < 11){
            return UIImage(named:"\(rank.rawValue)_of_\(suit.simpleDescription())") ?? UIImage()
        } else {
            return UIImage(named:"\(rank.simpleDescription())_of_\(suit.simpleDescription())") ?? UIImage()
        }
    }
}
