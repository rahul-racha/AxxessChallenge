//
//  ImageTypeView.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/30/21.
//

import UIKit
import Kingfisher

class ImageTypeView: UIView {
    
    // Image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        return imageView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.black
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    lazy var placeholderImage: UIImage? = {
        return UIImage(named: "placeholder")
    }()
    
    // ID
    let idHeaderLabel: UILabel = {
        let label = UILabel.getDefault(isBold: true, size: 20)
        label.text = "ID:"
        return label
    }()
    
    let idLabel: UILabel = {
        return UILabel.getDefault(size: 20)
    }()
    
    let idStackView: UIStackView = {
        return UIStackView.getDefault()
    }()
    
    // Type
    let typeHeaderLabel: UILabel = {
        let label = UILabel.getDefault(isBold: true, size: 20)
        label.text = "Type:"
        return label
    }()
    
    let typeLabel: UILabel = {
        return UILabel.getDefault(size: 20)
    }()
    
    let typeStackView: UIStackView = {
        return UIStackView.getDefault()
    }()
    
    // Date
    let dateHeaderLabel: UILabel = {
        let label = UILabel.getDefault(isBold: true, size: 20)
        label.text = "Date:"
        return label
    }()
    
    let dateLabel: UILabel = {
        return UILabel.getDefault(size: 20)
    }()
    
    let dateStackView: UIStackView = {
        return UIStackView.getDefault()
    }()
    
    let defaultText = "Not Available"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        addSubview(activityIndicator)
        
        addSubview(idStackView)
        idStackView.addArrangedSubview(idHeaderLabel)
        idStackView.addArrangedSubview(idLabel)
        
        addSubview(typeStackView)
        typeStackView.addArrangedSubview(typeHeaderLabel)
        typeStackView.addArrangedSubview(typeLabel)
        
        addSubview(dateStackView)
        dateStackView.addArrangedSubview(dateHeaderLabel)
        dateStackView.addArrangedSubview(dateLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(150)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(imageView.snp.width).multipliedBy(1 / 1)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(imageView)
        }
        
        idStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(25).priority(.low)
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        typeStackView.snp.makeConstraints { make in
            make.left.equalTo(idStackView)
            make.right.equalToSuperview().inset(25).priority(.low)
            make.top.equalTo(idStackView.snp.bottom).offset(15)
        }
        
        dateStackView.snp.makeConstraints { make in
            make.left.equalTo(idStackView)
            make.right.equalToSuperview().inset(25).priority(.low)
            make.top.equalTo(typeStackView.snp.bottom).offset(15)
            make.bottom.greaterThanOrEqualToSuperview().inset(20)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
    }
    
    func configureValues(imageUrl imageStr: String?, id: String?,
                         type: String?, date: String?) {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        if let str = imageStr, let url = URL(string: str) {
            imageView.kf.setImage(with: url) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(_):
                        self?.imageView.image = self?.placeholderImage
                    default:
                        break
                    }
                }
            }
        } else {
            imageView.image = placeholderImage
        }
        idLabel.text = id ?? defaultText
        typeLabel.text = type ?? defaultText
        dateLabel.text = date ?? defaultText
    }
}
