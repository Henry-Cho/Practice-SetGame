//
//  SetGameView.swift
//  Practice SetGame
//
//  Created by Henry Cho on 10/24/23.
//

import SwiftUI

struct SetGameView: View {
    let setGame: SetGameViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
                VStack {
                    topMenu
                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(setGame.cardsOnScreen) { card in
                            CardView(card: card)
                                .onTapGesture {
                                        setGame.choose(card)
                                }
                                .transition(AnyTransition.asymmetric(
                                    insertion: .offset(randomOnscreenLocation),
                                    removal: .offset(randomOffscreenLocation)
                                ))

                        }
                    }
                    Spacer()
                    bottomMenu
                }
                
                .padding()
            
        }
        .onAppear {
            setGame.initialDealCards()
        }
       
    }
    
    private func columns(for size: CGSize) -> [GridItem] {
        let minColumns = 2
        var columns = minColumns
        let visibleCardCount = setGame.cardsOnScreen.count

        while true {
            columns += 1
            let spacingWidth = CGFloat(columns - 1) * CardConstants.paddingScaleFactor
            let proposedCardWidth = (size.width - spacingWidth) / CGFloat(columns)
            let rows = Int(ceil(Double(visibleCardCount) / Double(columns)))

            let heightRequired = CGFloat(rows) * (proposedCardWidth / CardConstants.aspectRatio) + CGFloat(rows - 1) * CardConstants.paddingScaleFactor
            if heightRequired <= size.height * 0.9 {
                break
            }
        }

        return Array(repeating: GridItem(.flexible()), count: columns)
    }
    
    private var randomOnscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let angle = Double.random(in: 0..<360)
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }
    
    private var randomOffscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let angle = Double.random(in: 0..<360)
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return CGSize(width: x, height: y)
    }
    
    var topMenu: some View {
        HStack{
            Text("SET Game")
                .font(.largeTitle)
                .bold()
            Spacer()
            VStack(alignment: .trailing) {
                Text("Score: \(setGame.score)")
            }
            .font(.headline)
        }
    }
    
    var bottomMenu: some View {
        HStack {
            Button {
                setGame.newGame()
            } label: {
                Text("New Game")
            }
            Spacer()
            Text("Cards Left: \(setGame.deck.count)")
            Spacer()
            Button {
                for index in 0..<3 {
                    withAnimation(.linear.delay(Double(index) * CardConstants.animationDuration)) {
                        setGame.dealCard()
                    }
                }
            } label: {
                Text("Deal 3 More Cards")
            }
            .foregroundStyle(setGame.dealMoreCardsDisabled ? .gray : .blue)
            
        }
    }


}

#Preview {
    SetGameView(setGame: SetGameViewModel())
}
