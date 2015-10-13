//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// Naive Prime function

func naivePrime(number: Int) -> Bool {
    for i in 2...Int(sqrt(Double(number))) {
        if (number % i == 0) {
            
            return false
        }
    }
    
    return true
}

naivePrime(5)

// Extended Prime function

func isPrime(number: Int) -> Bool {
    let until = sqrt(Double(number))
    
    guard number >= 2 else {
        return false
    }
    
    guard until >= 2 else {
        return true
    }
    
    for i in 2...Int(until) {
        if (number % i == 0) {
            
            return false
        }
    }
    
    return true
}

isPrime(2)

// Alternative Prime functin

func altPrime(number: Int) -> Bool {
    
    switch number {
    case let n where n < 2: return false
    case 2, 3: return true
    default: break
    }
    
    for i in 2...Int(sqrt(Double(number))) {
        if (number % i == 0) {
            
            return false
        }
    }
    
    return true
}

altPrime(5)

