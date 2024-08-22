import SwiftUI

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "kIsLoggedIn")

    let kFirstName = "firstNameKey"
    let kLastName = "lastNameKey"
    let kEmail = "emailKey"
    let kIsLoggedIn = "kIsLoggedIn"

    var body: some View {
        NavigationView {
            if isLoggedIn {
                Home(isLoggedIn: $isLoggedIn)
            } else {
                VStack {
                    // Logo image at the top
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.top, 40)

                    TextField("First Name", text: $firstName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        }
                    }) {
                        Text("Register")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
