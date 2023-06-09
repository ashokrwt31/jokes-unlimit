//
//  ViewController.swift
//  JokeList
//
//  Created by Ashok Rawat on 08/06/23.
//

import UIKit

class JokeListViewController: UIViewController {
    
    private let cellIdentifier = "Cell"
    private var jokesViewModel: JokeListService
    private var jokesTableView = UITableView()
    private let navigationBar = UINavigationBar()
    private var gameTimer: Timer?
    private let indicator = ActivityIndicator()
    private var isFirstCall = true
    private var errorMessage: String = "Something went wrong!"
    
    private var jokes: [Joke] = [] {
        didSet {
            DispatchQueue.main.async {
                self.jokesTableView.reloadData()
            }
        }
    }
    
    init(jokesViewModel: JokeListService) {
            self.jokesViewModel = jokesViewModel
            super.init(nibName: nil, bundle: nil)
        }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupJokeTableView()
        
        fetchJokesFromServer()
        gameTimer = Timer.scheduledTimer(timeInterval: Constants.timeInterval, target: self, selector: #selector(fetchJokesFromServer), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        gameTimer?.invalidate()
    }
    
    deinit{
        gameTimer?.invalidate()
    }
}

extension JokeListViewController {
    private func setupNavigationBar() {
        navigationBar.customNavigationBar(title: Constants.LIST_SCREEN)
        view.addSubview(navigationBar)
        navigationBar.updateNavigationConstraint(self.view)
    }
    
    private func setupJokeTableView() {
       
        jokesTableView.dataSource = self
        jokesTableView.delegate = self
        jokesTableView.register(JokeTableCell.self, forCellReuseIdentifier: cellIdentifier)
        jokesTableView.rowHeight = UITableView.automaticDimension
        jokesTableView.separatorStyle = .none
        view.addSubview(jokesTableView)
        jokesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            jokesTableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            jokesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            jokesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            jokesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func fetchJokesFromServer() {
        activityIndicator(false)
        jokesViewModel.fetchJokes(completion: { [weak self] (joke, error) in
            if let joke = joke {
                self?.jokes = joke
            } else {
                self?.showAlertMessage(error)
            }
            self?.activityIndicator(true)
        })
    }
    
    private func activityIndicator(_ isHidden: Bool) {
        if !isFirstCall { return }
        if isHidden {
            isFirstCall = false
            indicator.hideIndicatorView()
        }
        else {
            indicator.startIndicatorView(uiView: view, style: .medium)
        }
    }
    
    private func showAlertMessage(_ error: Error?) {
        if let error = error {
            errorMessage = error.localizedDescription
        }
        DispatchQueue.main.async {
            UIAlertController.showAlert(title: "Alert!", message: self.errorMessage, viewController: self)
        }
    }
}

// MARK: - Table View Data Source

extension JokeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: JokeTableCell = jokesTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! JokeTableCell
        let joke = jokes[indexPath.row].joke
        cell.configureCell(joke, indexPath)
        return cell
    }
}

// MARK: - Table View Delegate

extension JokeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
