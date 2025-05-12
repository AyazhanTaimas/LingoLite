import FirebaseAuth
import FirebaseFirestore
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    private var db = Firestore.firestore()
    
    func fetchProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document(uid).getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data() ?? [:]
                self.userProfile = UserProfile(
                    id: uid,
                    name: data["name"] as? String ?? "No Name",
                    email: Auth.auth().currentUser?.email ?? "",
                    birthdate: data["birthdate"] as? String ?? "Unknown"
                )

            } else {
                print("❌ Failed to fetch profile:", error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}
