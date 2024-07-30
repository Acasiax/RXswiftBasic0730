//
//  ButtonRxTapVsLabelRxTex.swift
//  RXswiftBasic0730
//
//  Created by 이윤지 on 7/31/24.
//

//
// MARK: - button.rx.tap과 label.rx.text의 차이점

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ButtonRxTapVsLabelRxTextVC: UIViewController {

    let disposeBag = DisposeBag()
    let button = UIButton()
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        demonstrateButtonTap()
        demonstrateLabelTextBinding()
    }

    private func setupUI() {
        view.addSubview(button)
        view.addSubview(label)
        
        button.setTitle("Tap Me", for: .normal)
        button.backgroundColor = .blue
        label.textColor = .black
        label.textAlignment = .center
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
        }
    }

    // button.rx.tap
    //
    // 🌱타입: ControlEvent<Void>
    // 🌱설명: 버튼이 탭될 때마다 이벤트를 방출하는 Observable임
    // 🌱특징:
    // - ControlEvent는 Observable을 상속하며 UI 이벤트와 관련된 특별한 기능을 제공함!
    // - 이벤트는 단순히 버튼이 탭될 때마다 Void 타입의 값을 방출
    // - 주로 subscribe를 통해 이벤트를 수신하고 처리 가능
    private func demonstrateButtonTap() {
        button.rx.tap
            .subscribe { _ in
                print("Button was tapped")
            }
            .disposed(by: disposeBag)
    }

    // label.rx.text
    //
    // 🌱타입: Binder<String?>
    // 🌱설명: UILabel의 text 속성을 반응형으로 설정할 수 있게 해주는 바인더이다!
    // 🌱특징:
    // - Binder는 ObserverType을 구현하여 값을 받아 UI 요소의 속성에 반영
    // - Binder는 주로 bind를 통해 사용되며, Observable에서 방출되는 값을 수신하여 UILabel의 text 속성에 설정
    // - Binder는 에러를 처리하지 않으며, 항상 메인 스레드에서 동작함!
    private func demonstrateLabelTextBinding() {
        let textObservable = Observable.just("Hello, RxSwift!")
        textObservable
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
}
