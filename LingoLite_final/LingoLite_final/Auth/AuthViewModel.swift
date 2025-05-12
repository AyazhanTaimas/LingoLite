import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        print("✅ Sign In successful")
    }

    func signUp(name: String, birthdate: String, email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = result.user.uid
        
        // Сохраняем дополнительные данные
        let userData: [String: Any] = [
            "name": name,
            "birthdate": birthdate
        ]
        
        try await db.collection("users").document(uid).setData(userData)
        print("✅ User created and data saved in Firestore")
    }
    
    func createAccount(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
        print("✅ Auth-only account created")
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }

    var isSignedIn: Bool {
        Auth.auth().currentUser != nil
    }
}
