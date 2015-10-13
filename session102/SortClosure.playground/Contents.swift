//: Playground - noun: a place where people can play

import UIKit

var letters = ["1", "2", "3", "4", "5"]

// 1
func backwards(s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

letters.sort(backwards)

// 2
letters.sort { (s1: String, s2: String) -> Bool in
    return s1 > s2
}

// 3
letters.sort { s1, s2 in return s1 > s2 }

// 4
letters.sort { $0 > $1 }

// 5
letters.sort(>)
