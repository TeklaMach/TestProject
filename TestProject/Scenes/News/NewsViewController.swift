//
//  NewsViewController.swift
//  TestProject
//
//  Created by Nana Jimsheleishvili on 23.11.23.
//

import UIKit
// the NewsViewController class was not fully initialized and we cannot use self in that context. error: Cannot assign value of type '(NewsViewController) -> () -> NewsViewController' to type '(any UITableViewDataSource)?'
//  to solve this move the setup of the dataSource and delegate to a separate method, such as setupTableView, and call this method after the NewsViewController has been fully initialized in the viewDidLoad method.
   
    final class NewsViewController: UIViewController {

        // MARK: - Properties
        private var tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
            return tableView
        }()

        private var news = [News]()
        private var viewModel: NewsViewModel = DefaultNewViewModel()

        // MARK: - View life cycle
        override func viewDidLoad() {
            super.viewDidLoad()

            setupTableView()
            viewModel.viewDidLoad()
            // my code is not working, so i add color to the main view, but it is useless 
            view.backgroundColor = .systemCyan
        }

        // MARK: - Setup TableView
        private func setupTableView() {
            // Set up dataSource and delegate after the NewsViewController is fully initialized
            tableView.dataSource = self
            tableView.delegate = self

            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)

            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }

    // MARK: - TableViewDataSource
    extension NewsViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return news.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else {
                fatalError("Could not dequeue NewsCell")
            }
            cell.configure(with: news[indexPath.row])
            return cell
        }
    }

    // MARK: - TableViewDelegate
    extension NewsViewController: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             100.0
        }
    }

    // MARK: - MoviesListViewModelDelegate
    extension NewsViewController: NewsViewModelDelegate {
        func newsFetched(_ news: [News]) {
            self.news = news
            tableView.reloadData()
        }

        func showError(_ error: Error) {
            print("error")
        }
    }
