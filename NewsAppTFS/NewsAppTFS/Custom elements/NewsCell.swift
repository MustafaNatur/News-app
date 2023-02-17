//
//  NewsCell.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 03.02.2023.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let imageURL:URL?
    let reviews:Int
    var imageData: Data? = nil
    
    init(title: String, imageURL: URL?, reviews: Int) {
        self.title = title
        self.imageURL = imageURL
        self.reviews = reviews
    }
}

class NewsCell: UITableViewCell {

    private var imageImageView = UIImageView()
    private var titleLabel = UILabel()
    private var viewsLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageImageView)
        addSubview(titleLabel)
        addSubview(viewsLabel)
        
        configureImageView()
        configureTitleLabel()
        configureViewsLabel()
        
        imageImageView.setImageConstrains(to: self)
        titleLabel.setTitleConstrains(to: self, imageView: imageImageView)
        viewsLabel.setViewsConstrains(to: self)
    }
    
    func set(with viewModel: NewsTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        viewsLabel.text = "\(viewModel.reviews) views 👀"
        if let data = viewModel.imageData {
            imageImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageImageView.image = UIImage(data: data)
                }
            }.resume()
        } 
    }
    
    func configureViewsLabel() {
        titleLabel.numberOfLines = 0
        viewsLabel.textColor = .gray
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureImageView() {
        imageImageView.layer.cornerRadius = 10
        imageImageView.clipsToBounds = true
        imageImageView.contentMode = .scaleAspectFill
        imageImageView.backgroundColor = .secondarySystemBackground
    }
    
    
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    
}
