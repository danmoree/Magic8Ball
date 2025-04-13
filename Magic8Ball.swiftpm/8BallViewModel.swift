//  CS 471 Group Project
//  8BallViewModel.swift
//  Magic8Ball
//
//  Created by Daniel Moreno, Matthew Quinones, and Brady Scaggari
//  on 4/7/25.
//
import SwiftUI
@MainActor // Run on the main thread, Concurrency things
class Magic8BallViewModel: ObservableObject {
    @Published var response: String = ""
    @Published var question: String = ""
    
    private let responses = [
        "Yes, definitely.",
        "Ask again later.",
        "Outlook not so good.",
        "You may rely on it.",
        "Don't count on it.",
        "Very doubtful.",
        "Signs point to yes.",
        "My sources say no."
    ]
    
    func shakeBall() {
        // Pick a random response
        response = responses.randomElement() ?? "Hmm..."
        
        // Haptic feedback
        let haptic = UIImpactFeedbackGenerator(style: .medium)
        haptic.impactOccurred()
        
    }
}
