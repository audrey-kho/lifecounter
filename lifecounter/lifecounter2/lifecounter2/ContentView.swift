//
//  ContentView.swift
//  lifecounter2
//
//  Created by stlp on 4/30/21.
//

import SwiftUI

struct ContentView: View {
    @State var loserMsg: String = ""
    @State var history: [String] = []
    @State var playersLost: Int = 0
    @State var gamePlay: Bool = false
    @ObservedObject var list: Players = Players()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: geometry.size.width * 0.08) {
                        Button(action: {
                            if (list.players.count < 8) {
                                addPlayer()
                            }
                        }, label: {
                            Text("Add Player").font(.system(size: geometry.size.width * 0.045))
                        }).disabled(gamePlay)
                        NavigationLink(
                            destination: HistoryView(histList: $history)) {
                                Text("History").font(.system(size: geometry.size.width * 0.045))
                            }
                        Button(action: {
                            if (list.players.count > 2) {
                                list.players.removeLast()
                            }
                        }, label: {
                            Text("Remove Player").font(.system(size: geometry.size.width * 0.045))
                        }).disabled(gamePlay)
                    }
                    ScrollView {
                        ZStack {
                            VStack (spacing: geometry.size.width * 0.3) {
                                ForEach(list.players, id: \.self) {player in
                                    PlayerTemplate(player: player, playersLost: $playersLost, loserMsg: $loserMsg, history: $history, gamePlay: $gamePlay)
                                }
                            }
                        }
                        VStack (spacing: geometry.size.height * 0.02) {
                            Text(loserMsg).font(.system(size: geometry.size.width * 0.05)).padding(.top)
                            Button(action: {
                                reset()
                            }, label: {
                                Text("Reset Game").font(.system(size: geometry.size.width * 0.05)).foregroundColor(.red)
                            })
                        }.padding(.top, geometry.size.width * 0.3)
                    }
                }.padding(.horizontal, geometry.size.width * 0.08)
            }
        }
    }
    
    private func addPlayer() {
        list.players.append(Player(name: "Player " + String(list.players.count + 1)))
    }
    
    private func reset() {
        list.players = Players().players
        playersLost = 0
        loserMsg = ""
        history = []
        gamePlay = false
    }
}

struct PlayerTemplate: View {
    @State var player: Player
    @State var lives: Int = 20
    @State var increment: Int = 1
    @State var lost: Bool = false
    @State var changeName: Bool = false
    @Binding var playersLost: Int
    @Binding var loserMsg: String
    @Binding var history:[String]
    @Binding var gamePlay: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack (alignment: .center, spacing: geometry.size.width * 0.01) {
                    HStack {
                        Button(action: {
                            self.changeName = true
                        }, label: {
                            Text(self.player.name).font(.system(size: geometry.size.width * 0.055)).foregroundColor(.black)
                        })
                        Spacer()
                        Text(String(self.lives)).font(.system(size: geometry.size.width * 0.055))
                    }.padding(.all)
                    HStack (alignment: .center, spacing: 25) {
                        // - button
                        Button(action: {
                            gamePlay = true
                            self.lives -= self.increment
                            if (self.lives <= 0 && !lost) {
                                self.lost = true
                                loserMsg = player.name + " loses!"
                                playersLost += 1
                                history.append(player.name + " lost")
                            } else {
                                history.append(player.name + " lost " + String(self.increment) + " lives")
                            }
                        }){
                            ZStack {
                                RoundedRectangle(cornerRadius: 8).fill(Color.init(.red))
                                Text("-").font(.system(size: 25)).foregroundColor(.white).frame(width: 10, height: 60, alignment: .center)
                            }
                        }
                        // num increment
                        TextField("", value: $increment, formatter: NumberFormatter()).multilineTextAlignment(.center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        // + button
                        Button(action: {
                            gamePlay = true
                            self.lives += self.increment
                            history.append(player.name + " got " + String(self.increment) + " lives")
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8).fill(Color.init(.systemGreen))
                                Text("+").font(.system(size: 20)).foregroundColor(.white)
                            }
                        }
                    }
                }
                if (self.changeName) {
                    ZStack {
                        Color.white
                        VStack (alignment: .center, spacing: 20) {
                            TextField("", text: $player.name).padding(.horizontal, 12).padding(.all, 5).multilineTextAlignment(.center).border(Color.gray.opacity(10), width: 1).cornerRadius(8)
                            Button("Rename Player", action: {
                                changeName = false
                            }).frame(width: 200, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }.frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
}

class Player: NSObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Players: ObservableObject {
    @Published var players: [Player] = []
    
    init() {
        players = [
            Player(name: "Player 1"),
            Player(name: "Player 2"),
            Player(name: "Player 3"),
            Player(name: "Player 4")
        ]
    }
}

struct HistoryView: View {
    @Binding var histList: [String]
    
    var body: some View {
        ScrollView {
            ForEach(histList, id: \.self) { item in
                Text(item)
                    .padding(.horizontal, 80)
                    .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
