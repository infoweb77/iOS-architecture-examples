//
//  ViewModelType.swift
//  MVVM-RxSwift
//
//  Created by alex on 10/08/2019.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
