//
//  CustomNumbersVC.swift
//  RXswiftBasic0730
//
//  Created by 이윤지 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CustomNumbersVC: UIViewController {
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let result = UILabel()

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupBindings()
    }

    func setupUI() {
        // UITextField 속성 설정
        [number1, number2, number3].forEach {
            $0.borderStyle = .roundedRect
            $0.keyboardType = .numberPad
            $0.placeholder = "숫자를 입력하세요(숫자를 실시간으로 합산하여 결과를 표시할 것임)"
            view.addSubview($0)
        }
        
        result.textColor = .black
        result.textAlignment = .center
        view.addSubview(result)

        // 오토레이아웃 설정
        setupConstraints()
    }

    func setupBindings() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text)
            .disposed(by: disposeBag)
    }
}


extension CustomNumbersVC {
    func setupConstraints() {
        number1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
        
        result.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.height.equalTo(40)
        }
    }
}
