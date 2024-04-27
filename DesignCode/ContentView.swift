//
//  ContentView.swift
//  DesignCode
//
//  Created by Meng To on 6/16/23.
//

import SwiftUI

struct ContentView: View {
    @State var isTapped = false
    @State var isActive = false
    @State var time = Date.now

    let timer =  Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(.image1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: isTapped ? 600 : 300)
                .frame(width: isTapped ? 390 : 360)
                .cornerRadius(isTapped ? 0 : 20)
                .offset(y: isTapped ? -200 : 0)
                .phaseAnimator([1,1.1], trigger: isTapped) {
                    content, phase in
                    content.scaleEffect(phase)
                } animation : { phase in
                    switch phase {
                        case 1: .bouncy
                        case 1.1: .easeOut(duration: 1)
                        default: .easeInOut
                    }
                }
                .phaseAnimator([1, 1.1], trigger: isTapped) {
                    content, phase in
                    content.blur(radius: phase == 1.1 ? 100 : 0)
                }
            
            content
                .padding(20.0)
                .background(.regularMaterial)
                .cornerRadius(20.0)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(linearGradient)
                )
                .padding(40)
                .offset(y: isTapped ? 220 : 80)
            
            play
                .frame(width: isTapped ? 220 : 50)
                .foregroundStyle(.primary, .white)
                .font(.largeTitle)
                .padding(20)
                .background(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(linearGradient)
                )
                .cornerRadius(20)
                .offset(y: isTapped ? 40 : -44)
        }
        .frame(maxWidth: 400)
        .dynamicTypeSize(.xSmall ... .xLarge)
    }
    
    var linearGradient: LinearGradient {
        LinearGradient(colors: [.clear, .primary.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var content: some View {
        VStack(alignment: .center) {
            Text("modern architecture, an isometric tiny house, cute illustration, minimalist, vector art, night view")
                .font(.subheadline)
            HStack(spacing: 8.0) {
                VStack(alignment: .leading) {
                    Text("Size")
                        .foregroundColor(.secondary)
                    Text("1024x1024")
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Type")
                        .foregroundColor(.secondary)
                    Text("Upscale")
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Date")
                        .foregroundColor(.secondary)
                    Text("Today 5:19")
                }
                .font(.subheadline)
                .fontWeight(.semibold)
            }
            .frame(height: 44.0)
            
            
            HStack {
                HStack {
                    Image(systemName: "ellipsis")
                        .symbolEffect(.pulse)
                    Divider()
                    Image(systemName: "sparkle.magnifyingglass")
                        .symbolEffect(.scale.up, isActive: isActive)
                    Divider()
                    Image(systemName: "face.smiling")
                        .symbolEffect(.appear,  isActive: isActive)
                }
                .padding()
                .frame(height: 44)
                .overlay(
                    UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(
                        topLeading: 0, bottomLeading: 20, bottomTrailing: 0, topTrailing: 20
                    ))
                    .strokeBorder(linearGradient)
                )
                .offset(x: -20, y: 20)
                
                Spacer()
                
                Image(systemName: "square.and.arrow.down")
                    .padding()
                    .frame(height: 44)
                    .overlay(
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(
                            topLeading: 20, bottomLeading: 0, bottomTrailing: 20, topTrailing: 0
                        ))
                        .strokeBorder(linearGradient)
                    )
                    .offset(x: 20, y: 20)
            }
        }
    }
    
    var play: some View {
        HStack (spacing: 20) {
            Image(systemName: "wand.and.rays")
                .frame(width: 44)
                .symbolEffect(.variableColor.iterative.reversing, options: .speed(3), value: isTapped)
                .symbolEffect(.bounce, value: isTapped)
                .opacity(isTapped ? 1 : 0)
                .blur(radius: isTapped ? 0 : 20)
            
            Image(systemName: isTapped  ? "pause.fill" : "play.fill")
                .frame(width: 44)
                .contentTransition(.symbolEffect(.replace))
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isTapped.toggle()
                    }
                }
            
            Image(systemName: "bell.and.waves.left.and.right.fill")
                .frame(width: 44)
                .symbolEffect(.bounce, options: .speed(3).repeat(3), value: isTapped)
                .opacity(isTapped ? 1 : 0)
                .blur(radius: isTapped ? 0 : 20)
                .onReceive(timer) { value in
                    time = value
                    isActive.toggle()
                }
                
        }
    }
}

#Preview {
    ContentView()
}
