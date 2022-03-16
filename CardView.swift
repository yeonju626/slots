//
//  CardView.swift
//  slots
//
//  Created by Yeonju Kang on 27/2/22.
//

import SwiftUI

struct CardView: View {
    @Binding var slots:String
    @Binding var background:Color
    private let transition:AnyTransition = AnyTransition.move(edge: .bottom)
    @Binding var win:Bool
   
    
    var body: some View {
        VStack {
            if slots == "apple" {
                Image(slots)
                .resizable()
                    .aspectRatio(1,contentMode: .fit)
                    .transition(transition)
               
            } else if slots == "cherry" {
                Image(slots)
                .resizable()
                .aspectRatio(1,contentMode: .fit)
                    .transition(transition)
            }
            else {
                Image(slots)
                .resizable()
                .aspectRatio(1,contentMode: .fit)
                    .transition(transition)
            }
        }
        .background(win ? background.opacity(1) : background.opacity(0.5))
            .cornerRadius(20)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(slots:Binding.constant("apple"), background: Binding.constant(Color.yellow), win:Binding.constant(false))
    }
}
