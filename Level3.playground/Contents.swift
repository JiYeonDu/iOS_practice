

class Calculator {

    var result: Double
    
    init (){
        self.result = 0
    }
    
    func calculate(oper: String, firstNumber: Int, secondNumber: Int) -> Double {
        switch oper {
        case "+":
            let addOperation = AddOperation()
            result = addOperation.operate(firstNumber, secondNumber)
        case "-":
            let subOperation = SubtractOperation()
            result = subOperation.operate(firstNumber, secondNumber)
        case "*":
            let mulOperation = MultiplyOperation()
            result = mulOperation.operate(firstNumber, secondNumber)
        case "/":
            let divOperation = DivideOperation()
            result = divOperation.operate(firstNumber, secondNumber)
        default:
            print("Error")
        }
        return result
    }
}

class AddOperation {
    func operate(_ firstNumber: Int, _ secondNumber: Int ) -> Double {
        return Double(firstNumber + secondNumber)
    }
}
class SubtractOperation {
    func operate(_ firstNumber: Int, _ secondNumber: Int ) -> Double {
        return Double(firstNumber - secondNumber)
    }
}
class MultiplyOperation {
    func operate(_ firstNumber: Int, _ secondNumber: Int ) -> Double {
        return Double(firstNumber * secondNumber)
    }
}
class DivideOperation {
    func operate(_ firstNumber: Int, _ secondNumber: Int ) -> Double {
        return Double(firstNumber / secondNumber)
    }
}

let calculator = Calculator()
let addResult = calculator.calculate(oper: "+", firstNumber: 10, secondNumber: 20)
let subtractResult = calculator.calculate(oper: "-", firstNumber: 10, secondNumber: 20)
let multiplyResult = calculator.calculate(oper: "*", firstNumber: 10, secondNumber: 20)
let divideResult = calculator.calculate(oper: "/", firstNumber: 10, secondNumber: 20)
let remainderResult = calculator.calculate(oper: "%", firstNumber: 10, secondNumber: 20)

print("addResult : \(addResult)")
print("subtractResult : \(subtractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
print("remainderResult : \(remainderResult)")
