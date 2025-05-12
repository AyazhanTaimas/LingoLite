import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var navigate = false
    @State private var showSignUp = false
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        ZStack {
            Color(hex: "#FFE66D")
                .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // 🔶 Заголовок
                VStack(spacing: 4) {
                    Text("LingoLite")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(hex: "#5E2C1F"))

                    Text("is")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(hex: "#D97C3C"))

                    Text("your language companion")
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "#D97C3C"))
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("E-mail")
                        .bold()
                        .foregroundColor(Color(hex: "#5E2C1F"))

                    TextField("Enter your email", text: $email)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        .autocapitalization(.none)

                    Text("Password")
                        .bold()
                        .foregroundColor(Color(hex: "#5E2C1F"))

                    SecureField("Enter your password", text: $password)
                        .padding()
                        .frame(height: 50)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    Button("Sign Up") {
                        showSignUp = true
                    }
                    .italic()
                    .foregroundColor(Color(hex: "#5E2C1F"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)
                }
                .padding(.horizontal, 32)

                // 🔘 Кнопка входа
                Button("Sign in") {
                    Task {
                        do {
                            try await viewModel.signIn(email: email, password: password)
                            navigate = true
                        } catch {
                            errorMessage = error.localizedDescription
                        }
                    }
                }
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#7B3F26"))
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal, 32)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)

                Spacer()
            }

            // 🔁 Навигация
            NavigationLink(destination: HomeView(), isActive: $navigate) {
                EmptyView()
            }
            NavigationLink(destination: SignUpView(), isActive: $showSignUp) {
                EmptyView()
            }
        }
        .navigationBarHidden(true)
    }
}
