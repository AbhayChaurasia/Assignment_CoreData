//
//  PhotoViewController.swift
//  Assignment
//
//  Created by Prince on 01/05/25.
//

import UIKit
import CoreData
import FirebaseAuth

class ProfileViewController: UIViewController {
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
    
    var refreshUser = false
    
    override func viewDidLoad() {
        self.setUpUI()
        super.viewDidLoad()
        
    }
    
    
    func setUpUI() {
        self.profileImageView.clipsToBounds  = true
        let borderColor = #colorLiteral(red: 0.1490196078, green: 0.631372549, blue: 0.9568627451, alpha: 1)
        profileImageView.layer.cornerRadius = 12
        logOutBtn.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = borderColor.cgColor
        profileImageView.contentMode = .scaleAspectFill
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if refreshUser{
            setupData()
        }
        
    }

    @IBAction func logoutAction(_ sender: UIButton) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        UserManager.shared.deleteUser()
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func setupData(){
        self.profileImageView.clipsToBounds  = true
        let borderColor = #colorLiteral(red: 0.1490196078, green: 0.631372549, blue: 0.9568627451, alpha: 1)
        profileImageView.layer.cornerRadius = 75
        
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = borderColor.cgColor
        profileImageView.contentMode = .scaleAspectFill
        emailLabel.text = "Email : \(UserManager.shared.fetchUser()?.email ?? "")"
        usernameLabel.text = "Username : \(UserManager.shared.fetchUser()?.name ?? "")"
        loadUserProfileImage()
    }

    func loadUserProfileImage() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            if let user = try context.fetch(fetchRequest).first,
               let imageData = user.profileImage,
               let image = UIImage(data: imageData) {
                self.profileImageView.image = image
            } else {
                print("⚠️ No user or image data found.")
            }
        } catch {
            print("❌ Failed to fetch user: \(error.localizedDescription)")
        }
    }

}

extension ProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {




    func selectImage() {
           let actionSheet = UIAlertController(title: "Select Image", message: nil, preferredStyle: .actionSheet)

           // Camera Option
           if UIImagePickerController.isSourceTypeAvailable(.camera) {
               actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                   self.presentImagePicker(sourceType: .camera)
                   self.refreshUser = false
               }))
           }

           // Photo Library Option
           actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { _ in
               self.presentImagePicker(sourceType: .photoLibrary)
               self.refreshUser = false
           }))

           // Cancel Option
           actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.refreshUser = true
           present(actionSheet, animated: true)
       }

       func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
           let imagePicker = UIImagePickerController()
           imagePicker.delegate = self
           imagePicker.sourceType = sourceType
           imagePicker.allowsEditing = true
           present(imagePicker, animated: true)
       }

       // MARK: - Image Picker Delegate
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           if let selectedImage = info[.originalImage] as? UIImage {
               profileImageView.image = selectedImage
           } else if let editedImage = info[.editedImage] as? UIImage {
               profileImageView.image = editedImage
           }

           dismiss(animated: true)
       }

       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           dismiss(animated: true)
       }
   }
