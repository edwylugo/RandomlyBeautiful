import SwiftUI

struct ImageSlideshowView: View {
    let category: String
    @StateObject private var loader = ImageLoader()
    @State private var scale: CGFloat = 1.0
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            if let image = loader.currentImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(scale)
                    .animation(.easeInOut(duration: 10), value: scale)
                    .transition(.opacity)
                    .onAppear {
                        withAnimation {
                            scale = 1.1
                        }
                    }
            } else {
                ProgressView()
            }

            VStack {
                Spacer()
                Text(loader.credit.uppercased())
                    .font(.caption)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            loader.fetchImages(for: category)
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }

    // MARK: - Timer Control

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 12, repeats: true) { _ in
            scale = 1.0
            loader.loadNextImage()

            // Reaplica o efeito Ken Burns
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    scale = 1.1
                }
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
#Preview {
    ImageSlideshowView(category: "cats")
}