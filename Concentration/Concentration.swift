//
//  Concentration.swift
//  Concentration
//
//  Created by Joel Mendoza on 6/16/19.
//  Copyright © 2019 MappSci. All rights reserved.
//

import Foundation

class Concentration
{
    var cards=[Card]()

    func chooseCard(at index: Int){
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }

    init(numberOfPairsOfCards: Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
    }
}
