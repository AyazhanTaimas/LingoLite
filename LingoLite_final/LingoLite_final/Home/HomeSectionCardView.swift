import SwiftUI

struct HomeSectionCardView<Destination: View>: View {
    let title: String
    let imageName: String
    let destination: Destination

    var body: some View {
        HStack(spacing: 16) {
            // 📷 Левая иконка на всю высоту
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60)
                .padding(.vertical, 10) // картинка не впритык

            // 📄 Текст и кнопка
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 20, weight: .semibold))
                    .padding(.top, 20)
                    .padding(.leading, 50) // слегка смещаем текст
                    .foregroundColor(.black)

                Spacer()

                HStack {
                    Spacer()
                    NavigationLink(destination: destination) {
                        Text("Start")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 7)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.bottom, 13)
                }
            }
            .padding(.vertical, 12)
        }
        .padding(.horizontal)
        .frame(height: 100) // ✅ контролируемая высота
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .cornerRadius(12)
    }
}
