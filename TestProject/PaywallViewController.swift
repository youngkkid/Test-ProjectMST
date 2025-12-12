import UIKit

final class PaywallViewController: UIViewController {

    private var selectedPlan: Plan = .year {
        didSet { updatePrices() }
    }

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Подписка"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textAlignment = .center
        return l
    }()

    private lazy var segmented: UISegmentedControl = {
        let s = UISegmentedControl(items: ["Месяц", "Год (-40%)"])
        s.selectedSegmentIndex = 1
        return s
    }()

    private lazy var priceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textAlignment = .center
        return l
    }()

    private lazy var infoLabel: UILabel = {
        let l = UILabel()
        l.text = "Покупка эмулируется. Реальный биллинг не используется."
        l.font = .systemFont(ofSize: 14)
        l.textColor = .secondaryLabel
        l.numberOfLines = 0
        l.textAlignment = .center
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
        title = "Paywall"

        segmented.addTarget(self, action: #selector(planChanged), for: .valueChanged)
        continueButton.addTarget(self, action: #selector(buyTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [titleLabel, segmented, priceLabel, infoLabel, continueButton])
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

        updatePrices()
    }

    private func updatePrices() {
        switch selectedPlan {
        case .month:
            priceLabel.text = "99 ₽ / месяц"
        case .year:
            priceLabel.text = "713 ₽ / год (вместо 1188 ₽)"
        }
    }

    @objc private func planChanged() {
        selectedPlan = (segmented.selectedSegmentIndex == 0) ? .month : .year
    }

    @objc private func buyTapped() {
        // Эмуляция “покупки”
        UserDefaults.standard.set(true, forKey: StorageKeys.hasSubscription)
        UserDefaults.standard.set(selectedPlan.rawValue, forKey: StorageKeys.selectedPlan)

        // Переходим на главный экран и “сбрасываем” стек
        let main = MainViewController()
        navigationController?.setViewControllers([main], animated: true)
    }
}
