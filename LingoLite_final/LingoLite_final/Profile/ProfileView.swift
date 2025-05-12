import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ProfileViewModel()
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            // 🔶 Верхняя панель
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Profile")
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(hex: "#8F3B17"))
                    .padding()
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(Color(hex: "#FFE66D"))

            if let user = viewModel.userProfile {
                Spacer().frame(height: 24)

                // 🔵 Аватар-заглушка
                if let urlString = user.photoURL, let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 150, height: 150)
                }


                // 🔤 Имя
                Text(user.name)
                    .font(.title)
                    .bold()
                    .padding(.top)

                // 📄 Данные
                Group {
                    profileRow(label: "e-mail:", value: user.email)
                    profileRow(label: "password:", value: "********")
                    profileRow(label: "date of birth:", value: user.birthdate)
                }
                .padding(.top, 10)

                Spacer()

                // 🔘 Кнопки
                VStack(spacing: 16) {
                    Button("EDIT") {
                        // Действие для редактирования профиля
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#8F3B17"))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("SIGN OUT") {
                        do {
                            try authViewModel.signOut()
                            // Перейти обратно к экрану входа
                            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                                scene.windows.first?.rootViewController = UINavigationController(rootViewController: UIHostingController(rootView: SignInView()))
                                scene.windows.first?.makeKeyAndVisible()
                            }
                        } catch {
                            print("❌ Sign out error: \(error.localizedDescription)")
                        }
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#3B170A"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            } else {
                Spacer()
                ProgressView("Loading...")
                Spacer()
            }
        }
        .onAppear {
            viewModel.fetchProfile()
        }
    }

    private func profileRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .bold()
            Spacer()
            Text(value)
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
