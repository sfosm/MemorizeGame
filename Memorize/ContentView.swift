//
//  ContentView.swift
//  Memorize
//
//  Created by Adrian Szewczak on 15/05/2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: EmojisMemoryGame
    
    var body: some View {
        
        let columns = [
            GridItem(.adaptive(minimum: 65)),
        ]
        
        VStack{
            Text("Memorize").font(.largeTitle)
            if(viewModel.getActualTheme() == nil || viewModel.isGameDone()){
                List{
                    ForEach(viewModel.themes){ theme in
                        Text(theme.getThemeName())
                            .foregroundColor(viewModel.colorParser(theme.getThemeColor()!))
                            .onTapGesture {
                                viewModel.chooseTheme(theme)
                            }
                    }
                }
            }else{
                HStack{
                    Text(viewModel.getActualTheme()!.getThemeName())
                        .font(.title3)
                    Spacer()
                    Text("Score: \(viewModel.returnScore())")
                        .font(.title3)
                }.padding()
                ScrollView{
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.cards){ card in
                                CardView(card: card)
                                    .aspectRatio(2/3, contentMode: .fit)
                                    .foregroundColor(viewModel.colorParser(card.color!))
                                    .onTapGesture {
                                        viewModel.choose(card)
                                    }
                            }
                        }.padding()
                }
            }
        }
    }
    
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        ZStack{
            if(card.isFaceUp){
                RoundedRectangle(cornerRadius: 25).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 25).stroke()
                Text(card.content).font(.largeTitle)
            }else if card.isMatched{
                RoundedRectangle(cornerRadius: 25).opacity(0)
            }else{
                RoundedRectangle(cornerRadius: 25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let gameViewModel = EmojisMemoryGame()
        ContentView(viewModel: gameViewModel).preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
    }
}
