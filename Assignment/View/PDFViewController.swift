//
//  PDFViewController.swift
//  Assignment
//
//  Created by Prince on 02/05/25.
//

import UIKit
import WebKit

class PDFViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadPDF()
    }
    
    func loadPDF() {
        // Replace with your PDF URL
        if let pdfURL = URL(string: Endpoint.pdfURL) {
            let request = URLRequest(url: pdfURL)
            webView.load(request)
        } else {
            print("❌ Invalid PDF URL")
        }
    }

}
