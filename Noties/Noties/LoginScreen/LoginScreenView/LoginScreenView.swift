//
//  LoginScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import UIKit

class LoginScreenView: UIView {
    
    private var hasUsername = false
    private var isLongerThanEight = false
    private var createdUsername = false
    private var isAcceptable = false
    private var isAcceptable2 = false
    private var showsLoginMenu = true
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(registerButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username:"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Remember yourself?"
        textField.delegate = self
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Your secrets"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var startButton: UIButton = {
        let button = configureButton(title: "Start using Notie", imageName: "exit")
        button.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(usernameLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(startButton)
        return stackView
    }()
    
    private lazy var centerLoginStackViewConstraint =             loginStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    
    private let createUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a username:"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var createUsernameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.placeholder = "For example: Superstar"
        textField.delegate = self
        return textField
    }()
    
    private let createPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password:"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var createPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.placeholder = "8 characters, use 1 number"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm password:"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Repeat password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var proceedButton: UIButton = {
        let button = configureButton(title: "Register in Notie", imageName: "profile")
        button.addTarget(self, action: #selector(proceedButtonDidTap), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.addArrangedSubview(createUsernameLabel)
        stackView.addArrangedSubview(createUsernameTextField)
        stackView.addArrangedSubview(createPasswordLabel)
        stackView.addArrangedSubview(createPasswordTextField)
        stackView.addArrangedSubview(confirmPasswordLabel)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(proceedButton)
        return stackView
    }()
    
    private lazy var centerRegisterStackViewConstraint =             registerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 500)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension LoginScreenView: ViewSetuping {
    
    func loadViews(){
        [
            loginButton,
            registerButton,
            loginStackView,
            registerStackView
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configureLoginButtonConstraints()
        configureRegisterButtonConstraints()
        configureLoginStackViewConstraints()
        configureRegisterStackViewConstraints()
        
        [
            loginButton,
            registerButton,
            loginStackView,
            registerStackView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureLoginButtonConstraints() {
        [
            loginButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            loginButton.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 150)
        ].forEach { $0.isActive = true }
    }
    
    private func configureRegisterButtonConstraints() {
        [
            registerButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            registerButton.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 150)

        ].forEach { $0.isActive = true }
    }
    
    private func configureLoginStackViewConstraints() {
        [
            loginStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            loginStackView.widthAnchor.constraint(equalToConstant: 300),
            centerLoginStackViewConstraint
        ].forEach { $0.isActive = true }
    }
    
    private func configureRegisterStackViewConstraints() {
        [
            registerStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            registerStackView.widthAnchor.constraint(equalToConstant: 300),
            centerRegisterStackViewConstraint
        ].forEach { $0.isActive = true }
    }
    
}

//MARK: Configurating view

extension LoginScreenView {
    
    private func configureButton(title: String, imageName: String) -> UIButton {
        var font = AttributeContainer()
        font.font = .systemFont(ofSize: 16, weight: .bold)
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString("\(title)", attributes: font)
        config.baseForegroundColor = .white
        config.image = UIImage(named: "\(imageName)")
        config.imagePlacement = .trailing
        config.imagePadding = 48
        config.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 20, bottom: 17, trailing: 20)
        config.background.cornerRadius = 12
        config.titleAlignment = .leading
    
        let button = UIButton()
        button.configuration = config
        button.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        return button
    }
    
}


//MARK: Configurating Interaction

extension LoginScreenView: UITextFieldDelegate {
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func loginButtonDidTap() {
        self.endEditing(true)
        if !showsLoginMenu {
            showsLoginMenu.toggle()
            registerButton.backgroundColor = .gray
            loginButton.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
            self.centerLoginStackViewConstraint.constant += 500
            self.centerRegisterStackViewConstraint.constant += 500
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func registerButtonDidTap() {
        self.endEditing(true)
        if showsLoginMenu {
            loginButton.backgroundColor = .gray
            registerButton.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
            showsLoginMenu.toggle()
            self.centerLoginStackViewConstraint.constant -= 500
            self.centerRegisterStackViewConstraint.constant -= 500
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func startButtonDidTap() {
        self.endEditing(true)
    }
    
    @objc private func proceedButtonDidTap() {
        self.endEditing(true)
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.placeholder == "Remember yourself?" {
            if textField.text?.count ?? 0 > 0 {
                self.hasUsername = true
            } else {
                self.hasUsername = false
            }
        }
        
        if textField.placeholder == "Your secrets" {
            if textField.text?.count ?? 0 > 7 {
                self.isLongerThanEight = true
            } else {
                self.isLongerThanEight = false
            }
        }
        
        if hasUsername && isLongerThanEight {
            self.startButton.isEnabled = true
        } else {
            self.startButton.isEnabled = false
        }
        
        if textField.placeholder == "For example: Superstar" {
            if textField.text?.count ?? 0 > 0 {
                self.createdUsername = true
            } else {
                self.createdUsername = false
            }
        }
        
        if textField.placeholder == "8 characters, use 1 number" {
            if (textField.text?.count ?? 0 > 7) && (textField.text?.rangeOfCharacter(from: .decimalDigits) != nil) {
                self.isAcceptable = true
            } else {
                self.isAcceptable = false
            }
        }
        
        if textField.placeholder == "Repeat password" {
            if (textField.text?.count ?? 0 > 7) {
                self.isAcceptable2 = true
            } else {
                self.isAcceptable2 = false
            }
        }
        
        if createdUsername && isAcceptable && isAcceptable2 {
            self.proceedButton.isEnabled = true
        } else {
            self.proceedButton.isEnabled = false
        }
        
    }
    
}

