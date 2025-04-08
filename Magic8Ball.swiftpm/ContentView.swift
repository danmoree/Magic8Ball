import SwiftUI

// Mark the view model to run on the main actor.

// MARK: - Main View

struct ContentView: View {
    @StateObject var viewModel = Magic8BallViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 30) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 200, height: 200)
                        .scaleEffect(viewModel.isAnimating ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: viewModel.isAnimating)
                        .onTapGesture {
                            viewModel.shakeBall()
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
}
