//
//  ViewController.swift
//  RXswiftBasic0730
//
//  Created by 이윤지 on 7/30/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

/*
RxSwift 기초 개념 정리
비동기 프로그래밍

비동기 프로그래밍에서는 코드 실행이 외부 요인(예: 사용자 입력, 네트워크 요청 등)에 따라 달라질 수 있으며, 이러한 요인들을 처리하기 위해 이벤트 기반의 프로그래밍 모델을 사용합니다. RxSwift는 이러한 비동기 프로그래밍을 쉽게 할 수 있도록 도와줌

주요 개념

Observable:
역할: 이벤트를 전달
특징: 데이터 스트림을 생성하고, 다양한 이벤트를 방출합니다. 예를 들어, 버튼 클릭, 텍스트 입력, 네트워크 응답 등이 Observable로 표현
예시: button.rx.tap은 버튼이 클릭될 때마다 이벤트를 방출하는 Observable입니다.
Observer:
역할: 이벤트를 받아서 처리합니다.
특징: Observable이 방출하는 이벤트를 구독(subscribe)하여 필요한 작업을 수행합니다. 예를 들어, 레이블 업데이트, 화면 전환, 검색 결과 표시 등이 가능
예시: label.text = "버튼이 클릭됐어요"는 Observable의 이벤트를 받아서 레이블의 텍스트를 변경
Subscription (구독):
역할: Observer가 Observable을 구독하여 이벤트를 전달받습니다.
특징: 구독이 활성화된 동안 Observable이 이벤트를 방출하면 Observer가 이를 처리합니다. 구독을 취소(dispose)하면 더 이상 이벤트를 전달받지 않음
예시: button.rx.tap.subscribe(onNext: { ... })는 버튼 클릭 이벤트를 구독하는 예시입니다.
Binding (바인딩):
역할: Observable과 UI 요소를 연결하여 데이터를 자동으로 업데이트
특징: 주로 Driver와 함께 사용되어 UI 업데이트를 안전하게 수행합
예시: button.rx.tap.asDriver().drive(onNext: { ... })는 버튼 클릭 이벤트를 안전하게 UI에 반영
다양한 구독 방식

다양한 구독 방식을 사용하여 Observable의 이벤트를 처리 할 수 있음

옵저버블 시퀀스


 
 
 
 🌟큰 틀 정리!
 옵저버블 시퀀스

 Infinite Observable Sequence:

 끝이 없는 이벤트 전달.
 UI와 관련된 이벤트 처리에 자주 사용됨.
 예: Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
 Observable의 이벤트 처리 방식:

 next: 점진적인 데이터 전달.
 completed: 완료된 이벤트 전달.
 error: 오류 발생 시 이벤트 전달.
 이벤트를 방출하는 옵저버블과 이벤트를 처리하는 옵저버가 함께 동작하며, 이를 통해 비동기 프로그래밍을 쉽게 구현할 수 있습니다.
 
 
 
 🌱bind는
 예를 들어 UI는 애초에 complete, error 안할꺼면 애초에 next에 최적화된 친구를 만들기로 해서 다른 키워드로 나온 것이 바인드임!
 
 💡서브스크라이브랑 바인드의 차이는? 서브스크라이브는 언제 쓰고 바인드는 어제 쓰나요?

 
💡 UI는 왜 에러 이벤트가 발생하지 않나요?

 UI는 사용자와 상호작용하는 측면에서 에러나 완료 이벤트가 발생하는 것은 부자연스러움!. 사용자가 버튼을 클릭하거나 텍스트를 입력하는 등의 행위는 지속적으로 발생할 수 있는 이벤트라서. 이런 이유로 UI 요소에 대해선 에러나 완료 이벤트를 처리할 필요가 없으며, 오직 `next` 이벤트만 처리하면 됨.

 ### RxCocoa의 역할

 RxCocoa는 RxSwift를 기반으로 하는 라이브러리로, 주로 iOS의 UI 요소들을 Reactive하게 사용할 수 있도록 도와줍니다. UI 요소와 관련된 바인딩 작업을 단순화하고, 에러 처리나 완료 이벤트가 불필요한 UI 요소에 최적화된 바인딩 메서드를 제공하는 것임.
 그래서 UI는 예외처리가 많이 생기니깐 UI를 기반으로 예외처리 할 때 쓰도록 만들어진것이 RX코코아 이다.
 
*/




