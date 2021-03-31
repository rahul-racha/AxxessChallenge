//
//  ListTableViewCell.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/28/21.
//

import UIKit
import SnapKit

class ListTableViewCell: UITableViewCell {
    static let identifier: String = "\(ListTableViewCell.self)"
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    let typeLabel: UILabel = {
        return UILabel.getDefault(isBold: true, size: 16, textColor: .darkGray)
    }()
    
    let dateLabel: UILabel = {
        return UILabel.getDefault()
    }()
    
    let descLabel: UILabel = {
        let label = UILabel.getDefault()
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(typeLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(descLabel)
        
        containerView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        typeLabel.snp.makeConstraints { make -> Void in
            make.top.left.right.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make -> Void in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
        }
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        descLabel.snp.makeConstraints { make -> Void in
            make.top.bottom.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(10)
            make.right.lessThanOrEqualToSuperview()
        }
    }
    
    func setupCell(type: String?, date: String?, description: String?) {
        typeLabel.text = type
        dateLabel.text = date ?? "No Date"
        descLabel.text = type?.lowercased().contains("image") ?? false
            ? nil : description
    }

}

