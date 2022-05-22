//
//  ContentView.swift
//  Memorize
//
//  Created by Adrian Szewczak on 15/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State var emojiCount: Int = 0
    @State var emojis: [String] = []
    @State var actualSet = "none"
    let peopleEmojis: [String] = ["👶🏻","👧🏻","🧒🏻","👦🏻","👩🏻","🧑🏻","👨🏻","👩🏻‍🦱","🧑🏻‍🦱","👨🏻‍🦱","👩🏻‍🦰"]
    let flagsEmojis: [String] = ["🇨🇮","🏴","🏴‍☠️","🏁","🚩","🏳️‍🌈","🏳️‍⚧️","🇺🇳","🇦🇫","🇦🇱","🇩🇿","🇦🇩"]
    let animalsEmojis: [String] = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐻‍❄️","🐨"]
    var body: some View {
        
        let columns = [
            GridItem(.adaptive(minimum: 80)),
        ]
        
        VStack{
            Text("Memorize").font(.largeTitle)
            switch actualSet{
            case "people":
                Text("People set").font(.title3)
            case "animals":
                Text("Animals set").font(.title3)
            case "flags":
                Text("Flags set").font(.title3)
            default:
                Image(systemName: "sun.max").font(.title3)
            }
            ScrollView{
                if(actualSet != "none"){
                    LazyVGrid(columns: columns, spacing: 10){
                        ForEach(emojis, id: \.self){ emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                        }
                    }.padding()
                }else{
                    VStack{
                        Text("Please use menu below to choose your set")
                        Image(systemName: "arrow.down")
                    }.font(.title).padding()
                }
                
            }
            HStack{
                MenuTile(emojis: $emojis, actualSet: $actualSet, array: peopleEmojis, set: "people", imageName: "person.circle", text: "People")
                Spacer()
                MenuTile(emojis: $emojis, actualSet: $actualSet, array: flagsEmojis, set: "flags", imageName: "flag", text: "Flags")
                Spacer()
                MenuTile(emojis: $emojis, actualSet: $actualSet, array: animalsEmojis, set: "animals", imageName: "pawprint", text: "Animals")
            }.padding()
        }
    }
    
}

struct MenuTile: View{
    @Binding var emojis: [String]
    @Binding var actualSet: String
    var array: [String]
    var set: String
    var imageName: String
    var text: String
    var body: some View{
        Button{
            emojis = []
            emojis = array.shuffled()
            actualSet = set
        }label:{
            VStack{
                Image(systemName: imageName).font(.largeTitle)
                Text(text).font(.title3)
            }
        }
    }
}

struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 25).foregroundColor(.white)
            RoundedRectangle(cornerRadius: 25).stroke().foregroundColor(.blue)
            Text(content).font(.largeTitle)
            if(!isFaceUp){
                RoundedRectangle(cornerRadius: 25).foregroundColor(.blue)
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light).previewInterfaceOrientation(.portrait)
    }
}
