//
//  ViewController.swift
//  Driver
//
//  Created by Abdulsamad on 18/02/2022.
//

import UIKit
import RxSwift
import RxCocoa
class MainViewContorller: UIViewController {
    var viewModel = MainViewModel()
    let bag = DisposeBag()
    
    @IBOutlet weak var num1: UILabel!
    @IBOutlet weak var num2: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }


    func bindViewModel() {
        button.rx.tap.subscribe(viewModel.input.btnTapAction).disposed(by: bag)
        viewModel.output.num1.drive(num1.rx.text).disposed(by: bag)
        viewModel.output.num2.drive(num2.rx.text).disposed(by: bag)
    }
}

