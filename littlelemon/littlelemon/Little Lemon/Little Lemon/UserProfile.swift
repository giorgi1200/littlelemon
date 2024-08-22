//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Giorgi on 8/22/24.
//
import SwiftUI

struct UserProfile: View {
    @Binding var isLoggedIn: Bool

    let kIsLoggedIn = "kIsLoggedIn"

    var body: some View {
        VStack {
            Text("Personal information")
                .font(.largeTitle)
                .padding()

            Image("Profile")
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .padding()

            Text(UserDefaults.standard.string(forKey: "firstNameKey") ?? "")
            Text(UserDefaults.standard.string(forKey: "lastNameKey") ?? "")
            Text(UserDefaults.standard.string(forKey: "emailKey") ?? "")

            Button(action: {
                UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                isLoggedIn = false
            }) {
                Text("Logout")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(isLoggedIn: .constant(true))
    }
}
