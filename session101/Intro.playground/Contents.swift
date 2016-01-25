//: ### Build X: iOS Session 101 - Introduction to iOS

import UIKit

let constString = "Hey "
var str = "playground!"

let combine = constString + str

//: ### Array
//: * An array stores values of the same type in an ordered list.
//: * The same value can appear in an array multiple times at different positions.

let names = ["Anna", "James", "Jack"]
names[1]

//: ### Dictionary
//: * A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering.
//: * Each value is associated with a unique key, which acts as an identifier for that value within the dictionary.

let numberOfLegs = ["ant" : 6, "snake" : 0]
numberOfLegs["ant"]
numberOfLegs["human"]

//: ### Loops
//: * Swift provides two kinds of loop that perform a set of statements a certain number of times:
//:     * The **for-in** loop performs a set of statements for each item in a sequence.
//:     * The **for** loop performs a set of statements until a specific condition is met, typically by incrementing a counter each time the loop ends.

for var i = 0; i < 10; i++ {
    i
}

var index = 0
repeat {
    index++
} while index < 10

for name in names {
    name
}

for (animal, leg) in numberOfLegs {
    animal
    leg
}

//: ### If Statements
//: * Swift provides two ways to add conditional branches to your code, known as the if statement and the switch statement. 
//: * Typically, you use the if statement to evaluate simple conditions with only a few possible outcomes.

let bool = true
if bool {
    "true"
} else {
    "false"
}

//: ### Switch Statement
//: * A switch statement considers a value and compares it against several possible matching patterns.
//: * It then executes an appropriate block of code, based on the first pattern that matches successfully.

let counter = 3
switch counter {
case 0, 2, 4, 6, 8: "even"
case 1, 3, 5, 7, 9: "odd"
default: "failed"
}

//: ### Functions
//: * Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

func invokeMethod() {
    "hello"
}

invokeMethod()

func invokeMethod(input: String) {
    input
}

invokeMethod("Yo")

func sayHello(input: String) -> String {
    return "Hey " + input
}

sayHello("Peter")


