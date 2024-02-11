//
//  FunctionalComposition.swift
//  AmofintechTask
//
//  Created by Illia Kostiukevych on 07.02.2024.
//

precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator • : CompositionPrecedence

func •<A, B, C>(lhs: @escaping (A) -> B, rhs: @escaping (B) -> C) -> (A) -> C {
    return { rhs(lhs($0)) }
}

