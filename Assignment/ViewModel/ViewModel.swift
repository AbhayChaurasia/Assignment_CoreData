//
//  ViewModel.swift
//  Assignment
//
//  Created by Abhay Chaurasia on 12/05/25.
//

import Foundation
import Firebase
import GoogleSignIn
//import UIKit

class ViewModel {
    var onUserSaved: (() -> Void)?
    func checkLoggedInUser(completion: @escaping (Bool) -> Void) {
        let user = UserManager.shared.fetchUser()
        if let email = user?.email, !email.isEmpty {
            print("User already logged in")
            completion(true)
        } else {
            completion(false)
        }
    }

    func performGoogleSignIn(from viewController: UIViewController) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let configuration = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = configuration

        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
            if let error = error {
                print("Sign-in error: \(error.localizedDescription)")
                return
            }

            if let user = signInResult?.user {
                self.saveGoogleUserData(user: user)
            }
        }
    }

    private func saveGoogleUserData(user: GIDGoogleUser) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }

        let userData = User(context: context)
        userData.name = user.profile?.name
        userData.email = user.profile?.email

        if let imageURL = user.profile?.imageURL(withDimension: 200) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                guard let data = data, error == nil else {
                    print("Image download failed: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                userData.profileImage = data
                do {
                    try context.save()
                    print("✅ User saved.")
                           DispatchQueue.main.async {
                               self.onUserSaved?()
                           }
                    print("Google user data saved with profile image.")
                } catch {
                    print("Failed to save user data: \(error.localizedDescription)")
                }
            }.resume()
        } else {
            do {
                try context.save()
                print("Google user data saved (without image).")
            } catch {
                print("Failed to save user data: \(error.localizedDescription)")
            }
        }
    }
}
