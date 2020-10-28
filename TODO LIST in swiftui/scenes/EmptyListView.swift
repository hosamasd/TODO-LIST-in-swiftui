//
//  EmptyListView.swift
//  TODO LIST in swiftui
//
//  Created by hosam on 10/27/20.
//

import SwiftUI

struct EmptyListView: View {
    
    @State private var isAnimated=false
    
    let images = [
        "illustration-no1","illustration-no2","illustration-no3"
    ]
    let tips = [
        "Use your time wisely.",
        "Slow and steady wins the race",
        "keep it short and sweet.",
        "put hard tasks first.",
        "Reward yourself after work.",
        "Collect tasks ahead of time.",
        "Each night schedule for tomorrow."
    ]
    
    
    var body: some View {
        ZStack {
            VStack {
                Image(images.randomElement() ?? images[0])
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 256, idealWidth: 280, maxWidth: 360, minHeight: 256, idealHeight: 280, maxHeight: 360)
                    .layoutPriority(1)
                
                Text(tips.randomElement() ?? tips[0] )
                    .layoutPriority(0.5)
                    .font(.system(.headline, design: .rounded))
            }
            .padding(.horizontal)
            .opacity(isAnimated ? 1 : 0)
            .offset(y:isAnimated ? 0 : -50)
            .animation(.easeInOut(duration: 1.5))
            .onAppear(perform: {
                self.isAnimated.toggle()
            })
        }
        .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color("ColorBase"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environment(\.colorScheme, .dark)
    }
}
