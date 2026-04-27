//
//  ContentView.swift
//  memorize
//
//  Created by Ken Hsieh on 2026/3/16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Score: \(viewModel.score)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.orange)
                .padding(.top)
            cardList
                .animation(.default, value: viewModel.cards)
            Spacer()
            HStack(spacing: 24) {
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                Button("Restart") {
                    viewModel.restart()
                }
            }
            .font(.largeTitle)
        }
        .padding()
        .foregroundStyle(.orange)
    }
    
    var cardList: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            Group {
                shape.fill(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(Font.system(size: 300))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            
            shape.opacity(card.isFaceUp ? 0 : 1)
            
        }
        .opacity(card.isMatched && !card.isFaceUp ? 0 : 1)
    }
}



#Preview {
    ContentView(viewModel: EmojiMemoryGame())
    
}
