//
//  View extension.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 03.02.2023.
//

import UIKit

extension UITableView {
    func setConstrains(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}

extension UIImageView {
    func setImageConstrains(to superView:NewsCell) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 12).isActive = true
        heightAnchor.constraint(equalToConstant: 120).isActive = true
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: 4/3).isActive = true
    }
    
    func setFullImageConstrains(to superView:UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor, constant: 10).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 16).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -16).isActive = true
        heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}

extension UILabel {
    func setTitleConstrains(to superView:NewsCell, imageView: UIImageView) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        heightAnchor.constraint(equalToConstant: 95).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -10).isActive = true
        topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
    }
    
    func setViewsConstrains(to superView:NewsCell) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -10).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -10).isActive = true
    }
    
    func setFullTitleConstrains(from fromView:UIImageView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 20).isActive = true
        heightAnchor.constraint(equalToConstant: 95).isActive = true
        trailingAnchor.constraint(equalTo: fromView.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: fromView.leadingAnchor).isActive = true
    }
    
    func setFullDescriptionConstrains(from fromView:UILabel) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 20).isActive = true
        trailingAnchor.constraint(equalTo: fromView.trailingAnchor).isActive = true
        leadingAnchor.constraint(equalTo: fromView.leadingAnchor).isActive = true
    }
    
    func setFullDateConstrains(from fromView:UILabel) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: fromView.bottomAnchor, constant: 20).isActive = true
        leadingAnchor.constraint(equalTo: fromView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: fromView.trailingAnchor).isActive = true
    }
}

extension UIImageView {
    func set(with url: URL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }.resume()
    }
}

extension String {
    func getFormatDateString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.date(from: self)
        formatter.dateFormat = "y, MMM d, hh:mm"
        let result = formatter.string(from: date!)
        return result
    }
}

