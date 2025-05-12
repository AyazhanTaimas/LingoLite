import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct UserDetailsView: View {
    @State private var name = ""
    @State private var birthdate = Date()
    @State private var reason = ""
    @State private var errorMessage = ""
    @State private var isSaved = false

    var body: some View {
        ZStack {
            Color(hex: "#FFE66D").ignoresSafeArea()

            VStack(spacing: 24) {
                // 🔶 Верхняя панель
                HStack {
                    Text("←  Please tell us a bit about yourself.")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color(hex: "#8F3B17"))
                        .padding()
                    Spacer()
                }
                .background(Color(hex: "#FFE66D"))

                // 🧑 Заглушка аватара
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                    .frame(width: 150, height: 150)
                    .overlay(Text("place image").foregroundColor(.blue))

                VStack(alignment: .leading, spacing: 16) {
                    Text("Your name:")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    Text("Date of birth:")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    DatePicker("", selection: $birthdate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    Text("Why do you learn English?")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                    TextField("", text: $reason)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
                .padding(.horizontal)

                Spacer()

                Button("SAVE") {
                    saveUserDetails()
                }
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(hex: "#8F3B17"))
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.bottom)
            }

            NavigationLink(destination: HomeView(), isActive: $isSaved) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func saveUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let db = Firestore.firestore()

        db.collection("users").document(uid).setData([
            "name": name,
            "birthdate": formattedDate(birthdate),
            "reason": reason
        ]) { error in
            if let error = error {
                errorMessage = "❌ Failed to save: \(error.localizedDescription)"
            } else {
                isSaved = true
            }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        return formatter.string(from: date)
    }
}
