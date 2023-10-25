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
    
    var dealMoreCardsDisabled: Bool {
        if game.deck.count == 0 && game.cardsFilter(.matched).count != 0 {
            return false
        } else if game.deck.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    func initialDealCards() {
        game.dealTwelveCards()
    }
    
    func newGame() {
        game = SetGameModel()
        game.dealTwelveCards()
    }
    
    
    
}
