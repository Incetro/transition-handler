//
//  SecondViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import Layout
import TransitionHandler

// MARK: - SecondViewController

final class SecondViewController: UIViewController {

    // MARK: - Properties

    /// Second output
    weak var output: SecondViewControllerOutput?

    /// Label of module
    private let label: UILabel = {
        let label = UILabel()
        label.text = "You transition to Second Module!"
        return label
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Change background color of EnterViewController", for: .normal)
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

    // MARK: - Setup

    private func setup() {
        setupLabel()
        setupButton()
    }

    private func setupLabel() {
        view.addSubview(label.prepareForAutolayout())
        label
            .top(to: view.top + 80)
            .centerX(to: view.centerX)
    }

    private func setupButton() {
        view.addSubview(button.prepareForAutolayout())
        button
            .top(to: label.bottom + 90)
            .centerX(to: label.centerX)
            .height(80)
            .width(200)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func buttonAction() {
        output?.didTriggerSecondButtonTapped()
        self.closeCurrentModule().perform()
    }
}

// MARK: - FirstModuleInput

extension SecondViewController: SecondModuleInput {

    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        self.output = moduleOutput as? SecondViewControllerOutput
    }
}

// MARK: - Controller

extension SecondViewController: ViewOutputProvider {

    var viewOutput: ModuleInput? {
        self
    }
}
