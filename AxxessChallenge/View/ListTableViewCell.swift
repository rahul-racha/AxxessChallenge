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

        // Configure the view for the selected state
    }
    
    private func setupViews() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descLabel)
        
        typeLabel.snp.makeConstraints { make -> Void in
            make.top.left.equalTo(contentView).offset(5)
        }
        
        dateLabel.snp.makeConstraints { make -> Void in
            make.left.equalTo(typeLabel)
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.bottom.equalTo(contentView).inset(5)
        }
        
        descLabel.snp.makeConstraints { make -> Void in
            make.top.bottom.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(5)
            make.right.equalTo(contentView).inset(5)
        }
    }
    
    func setupCell(type: String, date: String, description: String) {
        typeLabel.text = type
        dateLabel.text = date
        descLabel.text = description
    }

}

