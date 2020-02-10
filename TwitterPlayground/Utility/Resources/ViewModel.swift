//
//  ViewModel.swift
//  TwitterPlayground
//
//  Created by Kyle Stewart on 2/9/20.
//  Copyright © 2020 Kyle Stewart. All rights reserved.
//

import Foundation

protocol ViewModel: ObservableObject {
    associatedtype StateType
    associatedtype Event

    var state: StateType { get set }

    func notify(event: Event)
}
