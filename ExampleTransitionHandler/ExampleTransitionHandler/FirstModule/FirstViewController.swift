//
//  FirstViewController.swift
//  ExampleTransitionHandler
//
//  Created by Alexander Lezya on 27.01.2021.
//

import TransitionHandler
import Layout

// MARK: - FirstViewController

final class FirstViewController: UIViewController {

    // MARK: - Properties

    /// First output
    weak var output: FirstViewControllerOutput?

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
        output?.didTriggerFirstButtonTapped()
        self.closeCurrentModule().perform()
    }
}

// MARK: - FirstModuleInput

extension FirstViewController: FirstModuleInput {

    func setModuleOutput(_ moduleOutput: ModuleOutput) {
        self.output = moduleOutput as? FirstViewControllerOutput
    }
}

// MARK: - Controller

extension FirstViewController: ViewOutputProvider {

    var viewOutput: ModuleInput? {
        self
    }
}
