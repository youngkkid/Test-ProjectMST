//
//  ViewController.swift
//  TestProject
//
//  Created by Илья Ануфриев on 12.12.2025.
//

import UIKit

class MainViewController: UIViewController {
    
        private let items = [
            "Пункт 1",
            "Пункт 2",
            "Пункт 3"
        ]

        private let tableView = UITableView(frame: .zero, style: .insetGrouped)

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Главный экран"

            tableView.dataSource = self
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: "Reset",
                style: .plain,
                target: self,
                action: #selector(resetTapped)
            )
        }

        @objc private func resetTapped() {
            // Для проверки тестового: “сбросить подписку”
            UserDefaults.standard.set(false, forKey: StorageKeys.hasSubscription)

            let onboarding = OnboardingViewController()
            navigationController?.setViewControllers([onboarding], animated: true)
        }
    }

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = "Любой контент"
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}
