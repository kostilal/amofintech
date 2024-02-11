//
//  UserDetailsViewController.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKNavigationDelegate {
    private var webView: WKWebView!
    private var titleString: String
    private var url: URL
    
    init(title: String, url: URL) {
        self.titleString = title
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    // MARK: - Life cycle
	override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleString
        self.tabBarController?.tabBar.isHidden = true

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
