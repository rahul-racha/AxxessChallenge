//
//  DetailViewController.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel!
    var scrollView: UIScrollView!
    var imageTypeView: ImageTypeView!
    var textTypeView: TextTypeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightText
        setupView()
        viewModel.viewStateBinding.bind { [unowned self] viewState in
            DispatchQueue.main.async {
                switch viewState {
                case .empty:
                    self.updateViewState(ChallengeData())
                case .success(let data):
                    self.updateViewState(data)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Details"
    }
    
    func setupView() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        imageTypeView = ImageTypeView()
        scrollView.addSubview(imageTypeView)
        textTypeView = TextTypeView()
        scrollView.addSubview(textTypeView)
        setupConstraints()
        imageTypeView.isHidden = true
        textTypeView.isHidden = true
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        imageTypeView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
            make.height.greaterThanOrEqualTo(20)
        }
        textTypeView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    private func updateViewState(_ data: ChallengeData) {
        if data.type?.lowercased().contains("image") ?? false {
            imageTypeView.configureValues(imageUrl: data.data, id: data.id, type: data.type, date: data.date)
            imageTypeView.isHidden = false
            textTypeView.isHidden = true
        } else {
            textTypeView.configureValues(id: data.id, type: data.type, date: data.date, desc: data.data)
            imageTypeView.isHidden = true
            textTypeView.isHidden = false
        }
        view.setNeedsLayout()
    }
}
