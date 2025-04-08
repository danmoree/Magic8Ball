//
//  ContentView.swift
//  Magic8Ball
//
//  Created by Daniel Moreno on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = Magic8BallViewModel()
    @State private var wobbleTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    // New: State to hold dynamic wobble scale
    @State private var randomScale: CGSize = CGSize(width: 1.0, height: 1.0)
    @State private var blobIntensity: CGFloat = 1.4

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                HStack {
                    Text("Magic 8 Ball")
                        .foregroundColor(.white)
                        .fontWidth(.expanded)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }

                Spacer()

                ZStack {
                    TimelineView(.animation) { timeline in
                        let time = timeline.date.timeIntervalSinceReferenceDate
                        let phase = CGFloat(time).truncatingRemainder(dividingBy: .pi * 2)

                        BlobShape(phase: phase, intensity: blobIntensity)
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                            .overlay(
                                Text(viewModel.response)
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                    .font(.headline)
                                    .padding()
                                    .frame(width: 180)
                            )
                            .onTapGesture {
                                viewModel.shakeBall()
                                
                                withAnimation(.easeOut(duration: 0.15)) {
                                    blobIntensity = 3.0 // 💥 blow up the edges
                                }

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                    withAnimation(.easeInOut(duration: 0.4)) {
                                        blobIntensity = 1.4 // return to normal
                                    }
                                }
                            }
                    }

                    Text(viewModel.response)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                }

                Spacer()

                TextField("Ask a question", text: $viewModel.question)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 40)
            }
            .padding()
        }
    }

    // MARK: - Wobble Generator

    func generateRandomWobbleScale() -> CGSize {
        let x = Double.random(in: 0.95...1.08)
        let y = 2.05 - x // Keeps the "liquid" balance between stretch and squish
        return CGSize(width: x, height: y)
    }

}
