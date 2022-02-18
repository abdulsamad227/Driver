//
//  ViewModel.swift
//  Driver
//
//  Created by Abdulsamad on 18/02/2022.
//

import Foundation
import RxSwift
import RxCocoa
protocol ViewModel {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}


class MainViewModel: ViewModel {
    private var buttonTapped = PublishSubject<Void>()
    let input: Input
    struct Input {
        let btnTapAction: AnyObserver<Void>
    }
    
    private var myRandom = PublishSubject<Int>()
    private var randomNum1:Driver<String>
    private var randomNum2:Driver<String>
    let output: Output
    struct Output {
        let num1: Driver<String>
        let num2: Driver<String>
    }
    let bag = DisposeBag()
    
    
    init() {
        input = Input(btnTapAction: buttonTapped.asObserver())
        
        randomNum1 = myRandom
            .map({ num in
                String(num)
            })
            .asDriver(onErrorJustReturn: "0")
        
        randomNum2 = myRandom
            .map({ num in
                String(num)
            })
            .asDriver(onErrorJustReturn: "0")
        output = Output(num1: randomNum1, num2: randomNum2)
        
        
        buttonTapped.subscribe(onNext: {
            self.getRandomNum()
        }).disposed(by: bag)
    }
    
    
    func getRandomNum(){
        let randomNumber = Int.random(in: 1...100)
        myRandom.onNext(randomNumber)
    }
}
