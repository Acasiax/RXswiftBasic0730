//
//  BasicPracticeVC.swift
//  RXswiftBasic0730
//
//  Created by 이윤지 on 7/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BasicPracticeVC: UIViewController {

    // 리소스 해제를 위한 DisposeBag 생성
    let myDisposeBag = DisposeBag()
    
    // UI 요소들 선언
    let myPickerView = UIPickerView()
    let myTableView = UITableView()
    let mySwitch = UISwitch()
    let mySwitchLabel = UILabel()
    let myTextField = UITextField()
    let myButton = UIButton()
    
    // 셀 식별자 정의
    let myCellIdentifier = "MyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        // 예제 1: Observable 생명주기
        createObservableLifecycle()

        // 예제 2: PickerView 설정
        setupPickerView()

        // 예제 3: TableView 설정
        setupTableView()

        // 예제 4: UISwitch 설정
        setupSwitch()

        // 예제 5: UITextField 및 UIButton 설정
        setupTextFieldAndButton()

        // 예제 6: Observable 예제들
        observableExamples()
    }
    
    private func configureView() {
        view.addSubview(myPickerView)
        view.addSubview(myTableView)
        view.addSubview(mySwitch)
        view.addSubview(mySwitchLabel)
        view.addSubview(myTextField)
        view.addSubview(myButton)
        
        // TableView 셀 등록
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: myCellIdentifier)
        
        // SnapKit 제약 조건 설정
        myPickerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        myTableView.snp.makeConstraints { make in
            make.top.equalTo(myPickerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        mySwitch.snp.makeConstraints { make in
            make.top.equalTo(myTableView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        mySwitchLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mySwitch)
            make.leading.equalTo(mySwitch.snp.trailing).offset(20)
        }
        
        myTextField.snp.makeConstraints { make in
            make.top.equalTo(mySwitch.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        myButton.snp.makeConstraints { make in
            make.top.equalTo(myTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
  
        myTextField.backgroundColor = .magenta
        mySwitchLabel.backgroundColor = .lightGray
        mySwitchLabel.text = "스위치 상태"
        
        view.backgroundColor = .white
        myButton.backgroundColor = .blue
        myButton.setTitle("버튼", for: .normal)
    }

    

    //MARK: - Observable 생명주기 예제 함수
    
    func createObservableLifecycle() {
        let observable = Observable<String>.create { observer in
            observer.onNext("첫 번째 이벤트")
            observer.onCompleted()
            return Disposables.create()
        }

        observable
            .subscribe(onNext: { event in
                print(event)
            }, onCompleted: {
                print("완료")
            })
            .disposed(by: myDisposeBag)
    }

    // PickerView 설정 함수
    func setupPickerView() {
        let items = Observable.just(["아이템 1", "아이템 2", "아이템 3"])

        items
            .bind(to: myPickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: myDisposeBag)
    }

    // TableView 설정 함수
    func setupTableView() {
        let items = Observable.just(["행 1", "행 2", "행 3"])

        items
            .bind(to: myTableView.rx.items(cellIdentifier: myCellIdentifier)) { _, item, cell in
                cell.textLabel?.text = "\(item)"
            }
            .disposed(by: myDisposeBag)
    }

    // UISwitch 설정 함수
    func setupSwitch() {
        mySwitch.rx.isOn
            .subscribe(onNext: { isOn in
                self.mySwitchLabel.text = isOn ? "스위치가 켜짐" : "스위치가 꺼짐"
            })
            .disposed(by: myDisposeBag)
    }

    // UITextField 및 UIButton 설정 함수
    func setupTextFieldAndButton() {
        myTextField.rx.text
            .orEmpty
            .bind(to: myButton.rx.title(for: .normal))
            .disposed(by: myDisposeBag)
    }

    // Observable 예제 함수
    func observableExamples() {
        // 예제: Just -> 단일 요소를 포함하는 Observable을 생성하고 구독하는 거 같음,
        Observable.just("단일 요소")
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: myDisposeBag)

        // 예제: Of -> "첫 번째 요소", "두 번째 요소", "세 번째 요소"라는 문자열을 순서대로 방출하는 거
        Observable.of("첫 번째 요소", "두 번째 요소", "세 번째 요소")
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: myDisposeBag)

        // 예제: From ->  배열 ["첫 번째 요소", "두 번째 요소", "세 번째 요소"]의 요소들을 순서대로 방출하는 거임
        Observable.from(["첫 번째 요소", "두 번째 요소", "세 번째 요소"])
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: myDisposeBag)

        // 예제: Take -> 처음 두 개의 요소 ("첫 번째", "두 번째")만 방출하고 나머지는 무시하는 거임
        Observable.of("첫 번째", "두 번째", "세 번째", "네 번째")
            .take(2)
            .subscribe(onNext: { element in
                print(element)
            })
            .disposed(by: myDisposeBag)
    }
}
