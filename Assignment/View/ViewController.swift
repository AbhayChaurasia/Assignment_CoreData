 
import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var pdfViewerBtn: UIStackView!
    @IBOutlet weak var apiCallBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!

    // MARK: - Properties
    private let viewModel = ViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
    }

    // MARK: - UI Setup
    private func setUI() {
        title = "List of Tasks"
        self.signInBtn.layer.cornerRadius = 8
        self.apiCallBtn.layer.cornerRadius = 8
        self.pdfViewerBtn.layer.cornerRadius = 8
        viewModel.checkLoggedInUser { [weak self] isLoggedIn in
            if isLoggedIn {
                DispatchQueue.main.async {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    vc.refreshUser = true
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                print("No user logged in")
            }
        }
    }

    // MARK: - Actions
    @IBAction func googleSignInAction(_ sender: UIButton) {
         
        
        viewModel.onUserSaved = {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                vc.refreshUser = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
    viewModel.performGoogleSignIn(from: self)
    }

    @IBAction func pdfAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PDFViewController") as! PDFViewController
        vc.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func coreDataAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListVC") as! ProductListVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
