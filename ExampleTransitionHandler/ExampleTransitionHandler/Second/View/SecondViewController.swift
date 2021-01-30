//
//  SecondViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import Layout
import TransitionHandler

// MARK: - SecondViewController

final class SecondViewController: UIViewController {
    
    // MARK: - Properties

    /// Presenter instance
    var output: SecondViewOutput?

    /// Label of module
    private let label: UILabel = {
        let label = UILabel()
        label.text = "You transitioned to Second Module!"
        return label
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Change background color of the EnterViewController", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .lightGray
        return button
    }()
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

// MARK: - Setup

extension SecondViewController {

    private func setup() {
        setupLabel()
        setupButton()
    }

    private func setupLabel() {
        view.addSubview(label.prepareForAutolayout())
        label
            .top(to: view.top + Constants.titleTopInset)
            .centerX(to: view.centerX)
    }

    private func setupButton() {
        view.addSubview(button.prepareForAutolayout())
        button
            .top(to: label.bottom + Constants.buttonTopInset)
            .centerX(to: label.centerX)
            .height(Constants.buttonSize.height)
            .width(Constants.buttonSize.width)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
}

// MARK: - Actions

extension SecondViewController {

    @objc func buttonAction() {
        output?.didTriggerSecondButtonTapped()
    }
}

// MARK: - SecondViewInput

extension SecondViewController: SecondViewInput {
}

// MARK: - ViperViewOutputProvider

extension SecondViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        output as? ModuleInput
    }
}

// MARK: - Constants

extension SecondViewController {

    enum Constants {
        static let titleTopInset: CGFloat = 80
        static let buttonTopInset: CGFloat = 90
        static let buttonSize: CGSize = CGSize(width: 200, height: 80)
    }
}
