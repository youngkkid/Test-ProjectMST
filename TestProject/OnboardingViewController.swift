import UIKit

final class OnboardingViewController: UIViewController {
    
        private lazy var titleLabel: UILabel = {
            let l = UILabel()
            l.text = "Добро пожаловать!"
            l.font = .systemFont(ofSize: 28, weight: .bold)
            l.numberOfLines = 0
            l.textAlignment = .center
            return l
        }()

    private lazy var subtitleLabel: UILabel = {
            let l = UILabel()
            l.text = "Это очень простое приложение для тестового задания."
            l.font = .systemFont(ofSize: 16, weight: .regular)
            l.numberOfLines = 0
            l.textAlignment = .center
            l.textColor = .secondaryLabel
            return l
        }()

    private lazy var continueButton: UIButton = {
            var config = UIButton.Configuration.filled()
            config.title = "Продолжить"
            config.cornerStyle = .large
            let b = UIButton(configuration: config)
            return b
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            title = "Onboarding"

            continueButton.addTarget(self, action: #selector(continueTapped), for: .touchUpInside)

            let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, continueButton])
            stack.axis = .vertical
            stack.spacing = 16
            stack.alignment = .fill

            view.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
            ])
        }

        @objc private func continueTapped() {
            navigationController?.pushViewController(PaywallViewController(), animated: true)
        }
    }
