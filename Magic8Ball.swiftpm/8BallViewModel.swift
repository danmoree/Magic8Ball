import SwiftUI
//
//  8BallViewModel.swift
//  Magic8Ball
//
//  Created by Daniel Moreno on 4/7/25.
//

@MainActor
class Magic8BallViewModel: ObservableObject {
    @Published var response: String = ""
    @Published var question: String = ""
    @Published var isAnimating: Bool = false
    
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
        
        // Haptic feedback on main thread.
        DispatchQueue.main.async {
            let haptic = UIImpactFeedbackGenerator(style: .medium)
            haptic.impactOccurred()
        }
        
        isAnimating = true
        // Using [weak self] to avoid a strong reference cycle.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.isAnimating = false
        }
    }
}
