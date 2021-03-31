//
//  TextTypeView.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/30/21.
//

import UIKit

class TextTypeView: UIView {
    // Description
    let descHeaderLabel: UILabel = {
        let label = UILabel.getDefault(isBold: true, size: 20)
        label.text = "Data"
        return label
    }()
    
    let descLabel: UILabel = {
        return UILabel.getDefault(size: 20, lines: 0)
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
        addSubview(idStackView)
        idStackView.addArrangedSubview(idHeaderLabel)
        idStackView.addArrangedSubview(idLabel)
        
        addSubview(typeStackView)
        typeStackView.addArrangedSubview(typeHeaderLabel)
        typeStackView.addArrangedSubview(typeLabel)
        
        addSubview(dateStackView)
        dateStackView.addArrangedSubview(dateHeaderLabel)
        dateStackView.addArrangedSubview(dateLabel)
        
        addSubview(descHeaderLabel)
        addSubview(descLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        idStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.right.equalToSuperview().inset(25).priority(.low)
            make.top.equalToSuperview().offset(20)
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
        }
        
        descHeaderLabel.snp.makeConstraints { make in
            make.left.equalTo(idStackView)
            make.right.equalToSuperview().inset(25).priority(.low)
            make.top.equalTo(dateStackView.snp.bottom).offset(15)
        }
        descLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(0)
            make.left.right.equalToSuperview().inset(25)
            make.top.equalTo(descHeaderLabel.snp.bottom).offset(5)
            make.bottom.greaterThanOrEqualToSuperview().inset(20)
        }
    }
    
    func configureValues(id: String?, type: String?,
                         date: String?, desc: String?) {
        idLabel.text = id ?? defaultText
        typeLabel.text = type ?? defaultText
        dateLabel.text = date ?? defaultText
        descLabel.text = desc ?? defaultText
//        descLabel.text = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc." + "\n" +
//
//        "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
//            +
//
//            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
//            +
//
//            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
//            +
//
//            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
//            +
//
//            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc."
    }
}
