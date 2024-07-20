//
//  WaveView.swift
//  week_1_program
//
//  Created by Akha on 11.05.2024.
//

import SwiftUI

struct WaveView: View {
    let amplitude: CGFloat = 100
    let wavelength: CGFloat = 200
    var phase: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = geometry.size.width
                let height = geometry.size.height
                let midHeight = height/2
                let frequency = .pi * 2 / wavelength
                
                path.move(to: CGPoint(x: 0, y: midHeight))
                for x in stride(from: 0, to: width, by: 1) {
                    let y = sin(frequency * x + phase) * amplitude + midHeight
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            .stroke(Color.blue, lineWidth: 2)
        }
    }
}

struct TestView: View {
    @State private var phase: CGFloat = 0

    var body: some View {
        WaveView(phase: phase)
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    phase += 1
                }
            }
    }
}

#Preview {
    TestView()
}
