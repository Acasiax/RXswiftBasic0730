//
//  CustomSimpleValidationVC.swift
//  RXswiftBasic0730
//
//  Created by 이윤지 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomSimpleValidationVC: UIViewController {
  
    let usernameTextField = UITextField()
    let usernameValidationLabel = UILabel()
    
    let passwordTextField = UITextField()
    let passwordValidationLabel = UILabel()
    
    let repeatedPasswordTextField = UITextField()
    let repeatedPasswordValidationLabel = UILabel()
    
    let signupButton = UIButton(type: .system)
    let signingUpIndicator = UIActivityIndicatorView(style: .medium)
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBindings()
    }

    func setupBindings() {
        // 간단한 유효성 검사
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= 3 }
            .share(replay: 1)

        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= 6 }
            .share(replay: 1)
        
        let repeatedPasswordValid = Observable.combineLatest(passwordTextField.rx.text.orEmpty, repeatedPasswordTextField.rx.text.orEmpty) {
            return $0 == $1
        }.share(replay: 1)

        let everythingValid = Observable.combineLatest(usernameValid, passwordValid, repeatedPasswordValid) {
            return $0 && $1 && $2
        }.share(replay: 1)

        usernameValid
            .bind(to: usernameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        repeatedPasswordValid
            .bind(to: repeatedPasswordValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: signupButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signupButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.signingUpIndicator.startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.signingUpIndicator.stopAnimating()
                    print("사용자가 가입되었습니다.")
                }
            })
            .disposed(by: disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
}


extension CustomSimpleValidationVC {
    func setupUI() {
       
        usernameTextField.placeholder = "사용자 이름"
        usernameTextField.borderStyle = .roundedRect
        usernameValidationLabel.text = "유효하지 않은 사용자 이름입니다. (3자 이상)"
        usernameValidationLabel.textColor = .red
        
        passwordTextField.placeholder = "비밀번호"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordValidationLabel.text = "유효하지 않은 비밀번호입니다. (6자 이상)"
        passwordValidationLabel.textColor = .red
        
        repeatedPasswordTextField.placeholder = "비밀번호 확인"
        repeatedPasswordTextField.borderStyle = .roundedRect
        repeatedPasswordTextField.isSecureTextEntry = true
        repeatedPasswordValidationLabel.text = "비밀번호가 일치하지 않습니다."
        repeatedPasswordValidationLabel.textColor = .red
        
        signupButton.setTitle("회원가입", for: .normal)
        signingUpIndicator.hidesWhenStopped = true
        
        // 뷰에 추가
        view.addSubview(usernameTextField)
        view.addSubview(usernameValidationLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidationLabel)
        view.addSubview(repeatedPasswordTextField)
        view.addSubview(repeatedPasswordValidationLabel)
        view.addSubview(signupButton)
        view.addSubview(signingUpIndicator)
        
        // 오토레이아웃 설정
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalTo(view).inset(20)
        }
        
        usernameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameValidationLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(20)
        }
        
        repeatedPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
        }
        
        repeatedPasswordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatedPasswordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(view).inset(20)
        }
        
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(repeatedPasswordValidationLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        signingUpIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(signupButton.snp.bottom).offset(20)
        }
    }
}
