//
//  ContentView.swift
//  slots
//
//  Created by Yeonju Kang on 17/2/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var credit = 1000
    @State var background = Array(repeating:Color.white,count:9)
    @State var slots = ["apple","cherry","star"]
    @State var numbers = Array(repeating:0,count:9)
    @State var win = false
    private var betAmount = 5
    
 
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red:9/255,green:85/255,blue:26/255))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Rectangle()
                .foregroundColor(Color(red:7/255,green:146/255,blue:38/255))
                .rotationEffect(Angle(degrees:45))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
               
                VStack{
                    Spacer()
                    HStack{
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .scaleEffect(2)
                        Text("Slots").font(.largeTitle).bold().foregroundColor(.white)
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .scaleEffect(2)
                    }
                   
                   Spacer()
                    Text("Credits:")
                        .bold()
                    Text(String(credit))
                        .bold()
                        .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal,30)
                        .background(win ? Color.yellow.opacity(1) : Color.white.opacity(0.5))
                        .animation(.none)
                        .cornerRadius(20)
                        .scaleEffect(win ? 1.2 : 1)
                        .animation(.spring(response: 0.7, dampingFraction:0.3 ))
                    Spacer()
 
                    VStack{
                        HStack{
         
                            CardView(slots: $slots[numbers[0]], background: $background[0], win: $win)
                            CardView(slots:  $slots[numbers[1]], background: $background[1], win: $win)
                            CardView(slots:  $slots[numbers[2]], background: $background[2], win: $win)
                        }
                        HStack{
         
                            CardView(slots: $slots[numbers[3]], background: $background[3], win: $win)
                            CardView(slots:  $slots[numbers[4]], background: $background[4], win: $win)
                            CardView(slots:  $slots[numbers[5]], background: $background[5], win: $win)
                        }
                        
                        HStack{
         
                            CardView(slots: $slots[numbers[6]], background: $background[6], win: $win)
                            CardView(slots:  $slots[numbers[7]], background: $background[7], win: $win)
                            CardView(slots:  $slots[numbers[8]], background: $background[8], win: $win)
                        }
                    }
                Spacer()
                    HStack{
                        VStack{
                            Button(action:{
                                //process a single spin
                                self.processResults()
                            
                            }){
                                Text("Spin")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                            .padding([.leading,.trailing],30)
                            .background(Color.pink)
                            .cornerRadius(20)
                            
                            Text("\(betAmount) credits").padding(.top,10)
                                .font(.footnote)
                            
                        }
                        VStack{
                            Button(action:{
                                //process a single spin
                                self.processResults(true)
                            
                            }){
                                Text("Max Spin")
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/)
                            .padding([.leading,.trailing],30)
                            .background(Color.pink)
                            .cornerRadius(20)
                            
                            Text("\(betAmount * 5) credits").padding(.top,10)
                                .font(.footnote)
                            
                        }
                    }
                }
        }
        .animation(.default)
    }
    func processResults(_ isMax:Bool=false){
        //set  background color back to white
        self.background = self.background.map{ _ in
            Color.white
        }
        
        if isMax {
            //spin all the cards
            self.numbers = self.numbers.map { _ in
                Int.random(in: 0...2)
            }
        }
        else{
            //spin the middle row
            self.numbers[3] = Int.random(in: 0...2)
            self.numbers[4] = Int.random(in: 0...2)
            self.numbers[5] = Int.random(in: 0...2)
        }

        processWin(isMax)
    }
    
    func processWin(_ isMax:Bool = false)
    {
        var matches = 0
        if !isMax{
            //processing single spin
            // Update credits based on match or not
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {
                // Match
                matches += 1
                
                //update background color to green
                self.background[3] = Color.yellow
                self.background[4] = Color.yellow
                self.background[5] = Color.yellow
                
                }
            }
            else {
                self.win = false
              //processing for max spin
                //top row
                if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2] {
                    // Match
                    matches += 1
                    
                    //update background color to green
                    self.background[0] = Color.yellow
                    self.background[1] = Color.yellow
                    self.background[2] = Color.yellow
                    
                    }
                //middle row
                if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5] {
                    // Match
                    matches += 1
                    
                    //update background color to green
                    self.background[3] = Color.yellow
                    self.background[4] = Color.yellow
                    self.background[5] = Color.yellow
                    
                    }
                //bottom row
                if self.numbers[6] == self.numbers[7] && self.numbers[7] == self.numbers[8] {
                    // Match
                    matches += 1
                    
                    //update background color to green
                    self.background[6] = Color.yellow
                    self.background[7] = Color.yellow
                    self.background[8] = Color.yellow
                    
                    }
                //diagonal top left to bottom right
                if self.numbers[0] == self.numbers[4] && self.numbers[4] == self.numbers[8] {
                    // Match
                    matches += 1
                    
                    //update background color to green
                    self.background[0] = Color.yellow
                    self.background[4] = Color.yellow
                    self.background[8] = Color.yellow
            }
                //diagonal top right to bottom left
                if self.numbers[2] == self.numbers[4] && self.numbers[4] == self.numbers[6] {
                    // Match
                    matches += 1
                    
                    //update background color to green
                    self.background[2] = Color.yellow
                    self.background[4] = Color.yellow
                    self.background[6] = Color.yellow
                }
                
                //check matches and distribute credits
                if matches > 0
                {
                    //at least 1 win
                    self.credit += matches * betAmount * 2
                    self.win = true
                }
                else if !isMax
                {
                    // 0 win, single spin
                    self.credit -= betAmount
                }
                else {
                    //0 win, max spin
                    self.credit -= betAmount*5
                }
                
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
