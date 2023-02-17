//
//  WebViewController.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 04.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    let webView = WKWebView()
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back to News", style: .plain, target: self, action: #selector(goToRoot))
        loadWebView()
    }
    
    private func loadWebView() {
        guard let url = URL(string: url!) else {return}
        let urlRequest = URLRequest(url: url)
        
        webView.load(urlRequest)
    }
    
    @objc private func goToRoot() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
