//
//  EnterViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import TransitionHandler
import Layout

// MARK: - EnterViewController

final class EnterViewController: UIViewController {
    
    // MARK: - Properties

    /// Presenter instance
    var output: EnterViewOutput?

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

    // MARK: - Ovarrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.5, alpha: 1)
        setup()
    }
}

// MARK: - Setup

extension EnterViewController {

    private func setup() {
        setupTitleLabel()
        setupButtons()
    }

    private func setupTitleLabel() {
        view.addSubview(titleLabel.prepareForAutolayout())
        titleLabel
            .top(to: view.top + Constants.titleTopInset)
            .centerX(to: view.centerX)
    }

    private func setupButtons() {
        view.addSubview(firstButton.prepareForAutolayout())
        firstButton
            .top(to: titleLabel.bottom + Constants.buttonTopInset)
            .centerX(to: view.centerX)
            .width(180)
            .height(30)
        firstButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        view.addSubview(secondButton.prepareForAutolayout())
        secondButton
            .top(to: firstButton.bottom + Constants.buttonsInset)
            .centerX(to: view.centerX)
            .width(equalTo: firstButton.width)
            .height(equalTo: firstButton.height)
        secondButton.addTarget(self, action: #selector(secondButtonAction), for: .touchUpInside)
    }
}

// MARK: - Actions

extension EnterViewController {

    @objc func firstButtonAction() {
        output?.didTriggerFirstButtonTapped()
    }

    @objc func secondButtonAction() {
        output?.didTriggerSecondButtonTapped()
    }
}

// MARK: - EnterViewInput

extension EnterViewController: EnterViewInput {

    func changeTitleText(_ text: String) {
        titleLabel.text = text
    }

    func changeBackgroundColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - ViperViewOutputProvider

extension EnterViewController: ViewOutputProvider {

    var viewOutput: ModuleInput? {
        output as? ModuleInput
    }
}

// MARK: - Constants

extension EnterViewController {

    enum Constants {
        static let titleTopInset: CGFloat = 80
        static let buttonTopInset: CGFloat = 40
        static let buttonsInset: CGFloat = 15
    }
}
