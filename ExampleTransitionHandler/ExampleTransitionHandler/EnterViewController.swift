//
//  EnterViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler
import Layout

// MARK: - EnterViewController

class EnterViewController: UIViewController {

    // MARK: - Properties

    /// Title label
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Welcome to Transition Handler example!"
        return titleLabel
    }()

    /// To transition on FirstModule
    private let firstButton: UIButton = {
        let firstButton = UIButton()
        firstButton.setTitle("First module", for: .normal)
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.backgroundColor = UIColor(red: 0.3, green: 1, blue: 0.3, alpha: 1)
        return firstButton
    }()

    /// To transition on SecondModule
    private let secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.setTitle("Second module", for: .normal)
        secondButton.setTitleColor(.black, for: .normal)
        secondButton.backgroundColor = UIColor(red: 1, green: 0.5, blue: 0.5, alpha: 1)
        return secondButton
    }()

    /// Your some input data
    private let someData: String = "You transition to First Module!"

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.5, alpha: 1)
        setup()
    }

    // MARK: - Setup

    private func setup() {
        setupTitleLabel()
        setupButtons()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .top(to: view.top + 80)
            .centerX(to: view.centerX)
    }

    private func setupButtons() {
        view.addSubview(firstButton.prepareForAutolayout())
        firstButton
            .top(to: titleLabel.bottom + 40)
            .centerX(to: view.centerX)
            .width(180)
            .height(30)
        firstButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)

        view.addSubview(secondButton.prepareForAutolayout())
        secondButton
            .top(to: firstButton.bottom + 20)
            .centerX(to: view.centerX)
            .width(equalTo: firstButton.width)
            .height(equalTo: firstButton.height)
        secondButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func firstButtonAction() {
        let transitionHandler: TransitionHandler = self
        transitionHandler
            .openModule(FirstModule.self, withData: someData)
            .to(.present)
            .then{ moduleInput in
                moduleInput.setModuleOutput(self)
            }
    }

    @objc func secondButtonAction() {
        let transitionHandler: TransitionHandler = self
        transitionHandler
            .openModule(SecondModule.self)
            .to(.present)
            .then { moduleInput in
                moduleInput.setModuleOutput(self)
            }
    }
}

// MARK: - FristViewControllerOutput

extension EnterViewController: FirstViewControllerOutput {

    func didTriggerFirstButtonTapped() {
        titleLabel.text = "You tapped button of First module"
    }
}

// MARK: - SecondViewControllerOutput

extension EnterViewController: SecondViewControllerOutput {

    func didTriggerSecondButtonTapped() {
        titleLabel.text = someData
        view.backgroundColor = UIColor(
            red: .random(in: 0.45...0.8),
            green: .random(in: 0.45...0.8),
            blue: .random(in: 0.45...0.8),
            alpha: 1
        )
    }
}
