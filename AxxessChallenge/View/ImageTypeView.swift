//
//  ImageTypeView.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/30/21.
//

import UIKit

class ImageTypeView: UIView {
    
    // Image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        
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
            make.left.top.right.equalToSuperview().inset(20)
            make.height.equalTo(imageView.snp.width).multipliedBy(1 / 1)
        }
        
        
    }
}
