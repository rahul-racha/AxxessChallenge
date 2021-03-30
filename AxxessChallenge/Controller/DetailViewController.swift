//
//  DetailViewController.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import UIKit

class DetailViewController: UIViewController {

    var scrollView: UIScrollView!
    var typeLabel: UILabel!
    var dateLabel: UILabel!
    var someData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purple
        // Do any additional setup after loading the view.
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
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
