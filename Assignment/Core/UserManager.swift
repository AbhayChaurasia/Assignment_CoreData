//
//  UserModel.swift
//  Assignment
//
//  Created by Prince on 02/05/25.
//

import UIKit
import CoreData

class UserManager {
    
    static let shared = UserManager()
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Save User
    func saveUser(name: String, email: String) {
        let user = User(context: context)
        user.name = name
        user.email = email
        
        do {
            try context.save()
            print("✅ User saved successfully.")
        } catch {
            print("❌ Error saving user: \(error.localizedDescription)")
        }
    }

    // MARK: - Fetch User
    func fetchUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            print("name: \(users.first?.name ?? "")", "email: \(users.first?.email ?? "")", "profile image: \(users.first?.profileImage)")
            return users.first
        } catch {
            print("❌ Error fetching user: \(error.localizedDescription)")
            return nil
        }
    }


    func deleteUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            for user in users {
                context.delete(user)
            }
            try context.save()
            print("🗑 User deleted on logout.")
        } catch {
            print("❌ Error deleting user: \(error.localizedDescription)")
        }
    }
}
