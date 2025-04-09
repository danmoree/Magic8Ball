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
    @State private var randomScale: CGSize = CGSize(width: 1.0, height: 1.0)
    @State private var blobIntensity: CGFloat = 1.4
    @State private var showBlob: Bool = true

    var body: some View {
        ZStack {
           // Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                HStack {
                    Text("Magic 8 Ball")
                       // .foregroundColor(.white)
                        .fontWidth(.expanded)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    
                    Spacer()
                }
                HStack {
                    Text("The future is wobbly and white.")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.top, -20)
                        .fontWidth(.expanded)
                        .fontWeight(.light)
                    
                    Spacer()
                }

                Spacer()

                if showBlob {
                    ZStack {
                        TimelineView(.animation) { timeline in
                            let time = timeline.date.timeIntervalSinceReferenceDate
                            let phase = CGFloat(time).truncatingRemainder(dividingBy: .pi * 2)

                            BlobShape(phase: phase, intensity: blobIntensity)
                               // .fill(Color.white)
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
                                        blobIntensity = 3.0
                                    }

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                        withAnimation(.easeInOut(duration: 0.4)) {
                                            blobIntensity = 1.4 // return to normal
                                        }
                                    }
                                }
                        }
                    }
                } else {
                    Text(viewModel.response)
                        //.multilineTextAlignment(.center)
                        .font(.headline)
                        .padding()
                        .frame(width: 180)
                }

                Spacer()

                HStack {
                    TextField("Question...", text: $viewModel.question)
                        .padding(.vertical, 12)
                        .padding(.leading, 16)
                        .onChange(of: viewModel.question) { newValue in
                            if newValue.isEmpty == false {
                                showBlob = true
                            }
                        }

                    if viewModel.question.isEmpty {
                        Image(systemName: "mic")
                            .padding(.trailing, 16)
                    } else {
                        Button(action: {
                            viewModel.shakeBall()
                            showBlob = false
                            withAnimation(.easeOut(duration: 0.15)) {
                                blobIntensity = 3.0
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                withAnimation(.easeInOut(duration: 0.4)) {
                                    blobIntensity = 1.4
                                }
                            }
                        }) {
                                Image(systemName: "arrow.up.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 28))
                                    .padding(.trailing, 10)
                                    
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(Color(.gray).opacity(0.2))
                )
        
                
            }
            .padding()
        }
    }

    

    func generateRandomWobbleScale() -> CGSize {
        let x = Double.random(in: 0.95...1.08)
        let y = 2.05 - x // Keeps the "liquid" balance between stretch and squish
        return CGSize(width: x, height: y)
    }

}
