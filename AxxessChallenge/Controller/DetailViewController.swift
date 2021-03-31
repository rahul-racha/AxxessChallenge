//
//  DetailViewController.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var scrollView: UIScrollView!
    var imageTypeView: ImageTypeView!
    var textTypeView: TextTypeView!
    var someData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        setupView()
    }
    
    func setupView() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        if (true) {
            imageTypeView = ImageTypeView()
            scrollView.addSubview(imageTypeView)
        } else {
            textTypeView = TextTypeView()
            scrollView.addSubview(textTypeView)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        if (true) {
            imageTypeView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView)
                make.width.equalTo(view)
                make.height.greaterThanOrEqualTo(20)
            }
        } else {
            textTypeView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView)
                make.width.equalTo(view)
                make.height.greaterThanOrEqualTo(20)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
