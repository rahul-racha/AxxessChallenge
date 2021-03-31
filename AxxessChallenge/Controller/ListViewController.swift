//
//  ListViewController.swift
//  AxxessChallenge
//
//  Created by Rahul Rachamalla on 3/27/21.
//

import UIKit
import SnapKit

protocol ListViewControllerDelegate: class {
    func didSelectItem(_ data: ChallengeData)
}

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel!
    weak var lvcDelegate: ListViewControllerDelegate?
    typealias UserIntent = ListViewModel.UserIntent
    private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSort()
        setupActivityIndicator()
        viewModel.viewStateBinding.bind { [unowned self] viewState in
            DispatchQueue.main.async {
                self.updateViewState(viewState)
            }
        }
        viewModel.intent = UserIntent.newData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "List"
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.rowHeight = 60
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footerView
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make -> Void in
            make.edges.equalTo(view)
        }
    }
    
    private func setupSort() {
        let btn = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortTapped(_:)))
        navigationItem.rightBarButtonItem = btn
    }

    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor.white
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.frame
        activityIndicator.backgroundColor = UIColor.init(white: 0, alpha: 0.3)
    }
    
    @objc func sortTapped(_ sender: UIBarButtonItem?) {
        let actionSheet = UIAlertController(title: "Sort", message: "Select an option to sort by 'type'", preferredStyle: .actionSheet)
        let ascOption = UIAlertAction(title: "Ascending", style: .default) { [weak self] _ in
            self?.viewModel.intent = .sort(true)
        }
        
        let descOption = UIAlertAction(title: "Descending", style: .default) { [weak self] _ in
            self?.viewModel.intent = .sort(false)
        }
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(ascOption)
        actionSheet.addAction(descOption)
        actionSheet.addAction(cancelOption)
        
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = sender
          }
        
        present(actionSheet, animated: true)
    }
    
    private func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func updateViewState(_ viewState: ListViewModel.ViewState) {
        switch viewState {
        case .loading:
            showActivityIndicator()
        case .error(let message):
            activityIndicator.stopAnimating()
            showAlert(message: message)
        case .loadData:
            if viewModel.challengeData.count > 0 {
                lvcDelegate?.didSelectItem(viewModel.challengeData[0])
            } else {
                showAlert(message: "No saved data found")
            }
            tableView.reloadData()
            fallthrough
        default:
            activityIndicator.stopAnimating()
        }
    }
    
    private func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.challengeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let data = viewModel.challengeData[indexPath.row]
        cell.setupCell(type: data.type,
                       date: data.date,
                       description: data.data)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.challengeData[indexPath.row]
        if UIDevice.current.userInterfaceIdiom == .phone {
            let detailVC = DetailViewController()
            detailVC.viewModel = DetailViewModel(viewState: .success(data))
            navigationController?.pushViewController(detailVC, animated: false)
        } else {
            lvcDelegate?.didSelectItem(data)
        }
    }
}

