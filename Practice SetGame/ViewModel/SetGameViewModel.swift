//
//  SetGameViewModel.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/25/23.
//

import Foundation

@Observable class SetGameViewModel {
    private var game = SetGameModel()
    
    var deck: [Card] {
        game.deck
    }
    
    var cardsOnScreen: [Card] {
        game.cardsOnScreen
    }
    
    var score: Int {
        game.score
    }
    
    func initialDealCards() {
        game.dealTwelveCards()
    }
    
    func newGame() {
        game = SetGameModel()
        game.dealTwelveCards()
    }
    
    
    
}
