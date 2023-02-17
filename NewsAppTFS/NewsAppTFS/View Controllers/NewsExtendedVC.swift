//
//  NewsExtendedVC.swift
//  NewsAppTFS
//
//  Created by Мустафа Натур on 04.02.2023.
//

import UIKit

class NewsExtendedVC: UIViewController {

    var article:Article?
    var imageData:Data?
    private var imageView = UIImageView()
    private var titleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var dateLabel = UILabel()
    private var linkLabel = UILabel()
    
    private lazy var scrollView: UIScrollView =  {
        let vc = UIScrollView()
        vc.backgroundColor = .systemBackground
        vc.frame = view.bounds
        vc.contentSize = contentSize
        return vc
    }()
    
    private lazy var contentView: UIView = {
        let vc = UIView()
        vc.backgroundColor = .systemBackground
        vc.frame.size = contentSize
        return vc
    }()
    
    private var contentSize:CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open in Web", style: .plain, target: self, action: #selector(showWeb))
        addingSubViews()
        configureNewsListVC()
        configureImageView()
        configureTitleLabel()
        configureDescriptionLabel()
        configureDateLavel()
        configureLinkLabel()
    }
    
    private func addingSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(dateLabel)
        scrollView.addSubview(linkLabel)
    }
    
    private func configureNewsListVC() {
        title = article?.source.name ?? "Unknown source"
        view.backgroundColor = .systemBackground
    }
    
    private func configureTitleLabel() {
        titleLabel.setFullTitleConstrains(from: imageView)
        titleLabel.font = UIFont.italicSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 0
        titleLabel.text = article?.title
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureImageView() {
          imageView.setFullImageConstrains(to: contentView)
          imageView.set(with: URL(string: article?.urlToImage ?? Constants.defaultLink)!)
          imageView.layer.cornerRadius = 20
          imageView.clipsToBounds = true
          imageView.contentMode = .scaleAspectFill
          imageView.backgroundColor = .secondarySystemBackground
      }
    
    private func configureDescriptionLabel() {
         descriptionLabel.setFullDescriptionConstrains(from: titleLabel)
         descriptionLabel.numberOfLines = 0
         let text = article?.description
         descriptionLabel.text = text
     }
    
    private func configureDateLavel() {
        dateLabel.setFullDateConstrains(from: descriptionLabel)
        dateLabel.numberOfLines = 0
        dateLabel.text = article?.publishedAt.getFormatDateString()
        dateLabel.textColor = .gray
        
    }
    
    private func configureLinkLabel() {
        linkLabel.setFullDateConstrains(from: dateLabel)
        linkLabel.numberOfLines = 0
        linkLabel.text = "Article link"
        linkLabel.textColor = .systemBlue
        
        linkLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(showWeb))
        tapGesture.numberOfTapsRequired = 1
        linkLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func showWeb() {
        let vc = WebViewController()
        vc.url = article?.url
        navigationController?.pushViewController(vc, animated: true)
    }
}
