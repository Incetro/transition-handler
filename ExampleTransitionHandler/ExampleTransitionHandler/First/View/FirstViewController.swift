//
//  FirstViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 28/01/2021.
//  Copyright © 2021 incetro. All rights reserved.
//

import Layout
import TransitionHandler

// MARK: - FirstViewController

final class FirstViewController: UIViewController {

    // MARK: - Properties

    /// Presenter instance
    var output: FirstViewOutput?

    /// Label of module
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    /// Button for changing text label of EnterViewController
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Change text of label on EnterViewController", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 0
        button.backgroundColor = .lightGray
        return button
    }()

    // MARK: - Initializer

    /// Default initializer
    /// - Parameter text: String instance
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        self.label.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
}

// MARK: - Setup

extension FirstViewController {

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

extension FirstViewController {
    
    @objc func buttonAction() {
        output?.didTriggerFirstButtonTapped()
    }
}

// MARK: - FirstViewInput

extension FirstViewController: FirstViewInput {
}

// MARK: - ViperViewOutputProvider

extension FirstViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        output as? ModuleInput
    }
}

// MARK: - Constants

extension FirstViewController {

    enum Constants {
        static let titleTopInset: CGFloat = 80
        static let buttonTopInset: CGFloat = 90
        static let buttonSize: CGSize = CGSize(width: 200, height: 80)
    }
}
