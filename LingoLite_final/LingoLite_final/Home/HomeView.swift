import SwiftUI

struct HomeView: View {
    @State private var showingProfile = false  // ← Не хватает этой строки

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // 🔶 Верхняя панель
                HStack {
                    Text("LingoLite")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: "#8F3B17"))
                    
                    Spacer()
                    
                    NavigationLink(destination: ProfileView(), isActive: $showingProfile) {
                        EmptyView()
                    }
                    .hidden()

                    Button(action: {
                        showingProfile = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color(hex: "#8F3B17"))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, -10)
                .padding(.bottom, 10)
                .background(Color(hex: "#FFE66D"))

                // 🔹 Заголовок
                HStack {
                    Text("Pick the section")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.horizontal)
                    Spacer()
                }
                .padding(.top, 20)

                // 🔸 Список секций
                ScrollView {
                    VStack(spacing: 20) {
                        HomeSectionCardView(title: "Word Breakdown", imageName: "brainstorm", destination: WordBreakdownView())
                        HomeSectionCardView(title: "Translator", imageName: "translator", destination: TranslatorView())
                        HomeSectionCardView(title: "AI-assistant", imageName: "ai", destination: ChatAssistantView())
                        HomeSectionCardView(title: "Visual Vocabulary", imageName: "picture", destination: VisualVocabView())
                        HomeSectionCardView(title: "Dictionary", imageName: "dictionary", destination: DictionaryView())
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
        }
    }
}
