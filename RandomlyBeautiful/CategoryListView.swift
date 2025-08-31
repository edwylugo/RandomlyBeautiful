import SwiftUI

struct CategoryListView: View {
    let categories = [
        "Airplanes", "Beaches", "Bridges", "Cats", "Cities", "Dogs",
        "Earth", "Forests", "Galaxies", "Landmarks", "Mountains",
        "People", "Roads", "Sports", "Sunsets"
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Título estilizado
                VStack(spacing: 4) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                        .padding(.top)
                }

                // Subtítulo
                Text("A selection of random, beautiful pictures from Unsplash.")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Lista de categorias
                List(categories, id: \.self) { category in
                    NavigationLink(destination: ImageSlideshowView(category: category)) {
                        Text(category)
                    }
                }
                .listStyle(.plain)
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.1)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .navigationBarHidden(true)
        }
    }
}
#Preview {
    CategoryListView()
}
