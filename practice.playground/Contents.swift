
/*

let opt1: Int? = 1
let opt2: Int? = 2
let num1: Int = 3

print(type(of: opt1))
print(opt1)


//optional 타입끼리의 연산
let res1 = opt1 + opt2 //error: Binary operator '+' cannot be applied to two 'Int?' operands
print(res1)

//optional Int 타입과 Int타입의 연산
let res2 = opt1 + num1 //error: Value of optional type 'Int?' must be unwrapped to a value of type 'Int'
print(res2)


///클로저
func solution(_ x:Int) -> Bool {
    let numString = String(x)
    let numList = numString.compactMap { Int(String($0)) }
    if x % (numList.reduce(0, +)) == 0 {
        return true
    }
    return false
}


let numString = "1243"
let numList = numString.compactMap { (String) -> [Int] in
    let str = String
    let num = str.count - 1
    print(str)
    var result = " "
    repeat{
        let index = str.index(str.startIndex, offsetBy: num)
    }
    
    return result
    
    }


let numbers = [1,2,3,4,5]
let sortedNumbers = numbers.sorted {(num1, num2) -> Bool in return num1 < num2}



//지연 저장 프로퍼티 예제
struct Person {
    var name: String = "jimmy" //저장 프로퍼티
    lazy var nickname: String = "adorable" + self.name //지연 저장 프로퍼티
}

var ally: Person = Person()
print(ally.nickname)
ally.name = "mike"
print(ally.nickname)
 */

/*
//closure
var answer: Int = Int.random(in: 100...999)
//print(String(answer))
//print(type(of: String(answer)))

//let inputList = String(inputVal).compactMap {Int(String($0))}

let answerToList = String(answer).compactMap { (str) -> Int in
    print(str)
    print(type(of: str))
    return Int(String(str)) ?? 0
}


//let inputList = String(answer).compactMap {Int($0)}

//Int($0)은 문자(Character)를 정수(Int)로 변환하려는 시도입니다. 그러나 Int() 생성자는 문자열(String)을 받아들이고, 이를 정수로 변환
//char형을 바로 Int로 변환할 수 없다. char -> str -> Int

print(answerToList)


var name: String = "Unknown" {
    willSet {
        print("현재 이름 = \(name), 바뀔 이름 = \(newValue)")
    }
    didSet {
        print("현재 이름 = \(name), 바뀌기 전 이름 = \(oldValue)")
    }
}
 
name = "Peter"


//타입 캐스팅 is
let str: String = "hello"

print(str is String)
print(str is Character)

class Person{

}

class Student: Person{

}

class Teacher: Person{

}

var personA: Person = Person()
//personA = Student() //가능
//personA = Teacher() //가능
var studentA: Student = Student()
//studentA = Person()
//studentA = Teacher()
var teacherA: Teacher = Teacher()
//teacherA = Person()
//teacherA = Student()

var result: Bool

result = personA is Person
result = personA is Student
result = personA is Teacher

result = studentA is Person
result = studentA is Student
result = studentA is Teacher


//업캐스팅, 다운캐스팅
class Person {
    var id = 0
    var name = "name"
}

class Worker: Person {
    var salary = 300
}

class Programmer: Worker{
    var lang = "swift"
}

//업캐스팅
var ally: Worker = Programmer() as Worker //programmer인스턴스를 생성하여 person 행세를 할 수 있도록
//print(ally.lang)    //Value of type 'Worker' has no member 'lang'
print(ally.salary)

var ben: Any = Person()

//다운캐스팅
let programmer1 = Programmer()
let worker1 = Worker()
let person1 = Person()

let worker2 = worker1 as? Worker
let worker3 = worker1 as? Person
let worker4 = worker1 as? Programmer
worker4?.lang

let person2 = person1 as? Person
let person3 = person1 as? Worker
let person4 = person1 as? Programmer
person3?.salary
person4?.lang

let programmer2 = programmer1 as? Person
let programmer3 = programmer1 as? Worker
let programmer4 = programmer1 as? Programmer


if let person5 = programmer1 as? Programmer {
    person5.lang
}
if let person6 = worker1 as? Programmer {
    person6.lang
}


let work1 = worker1 as! Person
let work2 = worker1 as! Worker
let work3 = worker1 as! Programmer


func solution(_ arr:[Int], _ divisor:Int) -> [Int] {
    var array = arr.compactMap { (num) -> Int? in
        if num % divisor == 0{
            return num
        } else {
            return nil
        }}
    if array.count == 0{
        return [-1]
    }
    return array.sorted(by: <)
}
print(solution([5,9,10,7], 5))
 */

/*
var array = [1,3,2,6,4]
array.map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)


let numbers = [1, 2, 3, 4, 5]
let strings = numbers.map { String($0) }
var string = numbers.map { (num) -> String in
    return "\(num)"
}

let strings = ["1", "2", "three", "4"]
var number = strings.map { Int($0) }
var number1 = strings.map { String(Int($0)!) }
print(number)
print(number1)

let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]

var evenNumbers = numbers.filter {$0 % 2 == 0}
print(evenNumbers)

var evenNumbers2 = numbers.filter({ num -> (Bool) in
    if num % 2 == 0{
        return true
    } else {
        return false
    }
})
print(evenNumbers2)
 */
/*
let numbers3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let sum1 = numbers3.reduce(0, +)
print(sum1)

let sum2 = numbers3.reduce(0, {$0 + $1} )
print(sum2)


let sum3 = numbers3.reduce(0, { (result, next) in
    return result + next
})
print(sum3)

let a: Set<Int> = [1,2,3,4,5]
let b: Set<Int> = [3,4,5,6,7]

let union: Set<Int> = a.union(b)
let intersection: Set<Int> = a.intersection(b)
let subtraction: Set<Int> = a.subtracting(b)
let symDif: Set<Int> = a.symmetricDifference(b)

var dict: Dictionary<String, Any> = [String: Any]()
dict["a"] = "value"
dict["b"] = 1
print(dict)

dict["b"] = 2

dict.removeValue(forKey: "b")
dict["a"] = nil

print(dict)
 

func solution(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    var result = 0
    var index = 0
    for sign in signs {
        if sign {
            result += absolutes[index]
        } else {
            result -= absolutes[index]
        }
        index += 1
    }
    return result
}

solution([1,2,3,4], [true,false,true,true])


protocol Vehicle {
    var speed: Double {get set}     //
    var manufacturer: String {get}
}

class Car: Vehicle {
    var speed: Double = 0.0
    var manufacturer: String = "Tesla"
}

class Bicycle: Vehicle {
    var speed: Double = 0.0
    var manufacturer: String {return "samJung"}
}
 */
/*
func solution(_ phone_number:String) -> String {
    var exceptLastFour = phone_number.count - 4
    var result = String(repeating: "*", count: exceptLastFour) + phone_number.suffix(4)
    return result
}

solution("01033334444")


let str1 = "hello"
let str2 = "swift"
print(str1+str2)

let combined = str1 + str2
print(combined)



var str1 = "hello swift"
var str2 = "swift"
//print(str1 - str2)

let startIndex = str1.index(str1.startIndex, offsetBy: 6)
let endIndex = str1.endIndex
str1.removeSubrange(startIndex..<endIndex)
print(str1)

extension String {
    var lastTwoWord: String {
        let suffixString = self.suffix(2)
        return String(suffixString)
    }
}

let str = "Hello"
print(str.lastTwoWord)


struct Matrix {
    private var data: [[Int]]
    
    init(rows: Int, columns: Int) {
        data = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }
}

extension Matrix {
    subscript(row: Int, column: Int) -> Int {
        get {
            return data[row][column]
        }
        set {
            data[row][column] = newValue
        }
    }
}

var matrix = Matrix(rows: 5, columns: 5)
matrix[0, 0] = 1
matrix[1, 1] = 3
print(matrix)


class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) 초기화")
    }
    deinit {
        print("\(name) 초기화해제")
    }
}

var ref1: Person?
var ref2: Person?
var ref3: Person?


class Company {
    var name: String
    weak var worker: Worker?
    
    init(name: String) {
        self.name = name
    }
    deinit { print("Company deinit")}
}

class Worker {
    var name: String
    var company: Company?
    
    init(name: String) {
        self.name = name
    }
    deinit { print("Worker deinit!") }
}

var ally: Worker?
var apple: Company?

ally = Worker(name: "ally")
apple = Company(name: "apple")

ally!.company = apple
apple!.worker = ally


func solution(_ numbers:[Int]) -> Int {
    var sum = numbers.reduce(0, +)
    print(sum)
    
    return -1
}

solution([1,2,3,4])


var list = [1,2,3,4]
var list1 = list.filter{ $0 % 2 == 0 }
var list2 = list.filter { !($0 % 2 == 0) }
print(list1)
print(list2)


func solution(_ arr:[Int]) -> [Int] {
    var minNum = arr.min()
    var result = arr.count != 1 ? arr.filter{ $0 != minNum } : [-1]
    return result
}

solution([1,2,3,4])
 */
/*
func solution(_ s:String) -> String {
    var length = s.count
    var result = ""
    let index = s.index(s.startIndex, offsetBy: length/2)
    if length % 2 != 0 {
        result.append(s[index])
    } else {
        let index1 = s.index(s.startIndex, offsetBy: length/2 - 1)
        result.append(s[index1])
        result.append(s[index])
    }
    return result
}

solution("qwer")

var str = "Hello, World!"
var substring = str.prefix(5) // "Hello"의 substring을 얻습니다.
print(substring) // 출력: "Hello"
substring = "swift"
print(str)
print(substring)
print(type(of: substring)) // 출력: Substring

func solution(_ n:Int) -> String {
    var result = ""
    for num in 1...n {
        if num % 2 == 0 {
            result.append("박박")
        } else {
            result.append("수")
        }
    }
    print(result)
    return result
}

solution(3)



import Foundation

func solution(_ a:[Int], _ b:[Int]) -> Int {
    var index = 0
    var result = a.compactMap { num1 in
        var res = num1 * b[index]
        index += 1
        return res
    }
    return result.reduce(0, +)
}

solution([1,2,3,4], [-3,-1,0,2])


let numbers = [1,2,3,4]
let numbers2 = [-3,-1,0,2]

let zipped = zip(numbers, numbers2)
for (zip) in  zipped {
    print(zip)
}
print(zipped)

import Foundation

func solution(_ left:Int, _ right:Int) -> Int {
    var result = 0
    for i in left...right{
        if getCount(i) % 2 == 0 {
            result += i
        } else {
            result -= i
        }
    }
    return result
}

func getCount(_ num:Int) -> Int {
    var result = 0
    for i in 1...num{
        if num % i == 0{
            result += 1
        }
    }
    return result
}

solution(13, 17)


func solution(_ s:String) -> String {
    var result = s.sorted(by: >)
    return result
}

solution("Zbcdefg")
 

func solution(_ price:Int, _ money:Int, _ count:Int) -> Int64{
    var answer:Int64 = -1
    var totalprice = 0
    for time in 1...count {
        totalprice += price * time
    }
    if money > totalprice {
        answer = 0
    } else {
        answer = Int64(totalprice - money)
    }
    return answer
}

solution(3, 20, 4)



func solution(_ s:String) -> Bool {
    if s.count == 4 || s.count == 6 {
        if let result = Int(s) {
            return true
        }
    }
    return false
}
solution("a234")
solution("1234")
*/

/*
func solution(_ arr1:[[Int]], _ arr2:[[Int]]) -> [[Int]] {
    var result: [[Int]] = []
    for i in 0...arr1.count-1 {
        var res: [Int] = []
        for j in 0...arr1[0].count-1 {
        res.append(arr1[i][j] + arr2[i][j])
        }
        result.append(res)
    }
    return result
}
solution([[1,2],[2,3]] , [[3,4],[5,6]])


//var array = [[1,2,3],[2,3]]


var array1 = [[1,2],[2,3]]
var array2 = [[3,4],[5,6]]
var result = array1.compactMap { li in

}

*/



/*
 let n = readLine()!.components(separatedBy: [" "]).map { Int($0)! }
 let (a, b) = (n[0], n[1])
 print(a,b)
 
 
 for _ in 1...3 {
 for _ in 1...5 {
 print("*", terminator: "")
 }
 print("")
 }
 
 
 
 
 func solution(_ n:Int, _ m:Int) -> [Int] {
 //최대공약수
 var max = n > m ? n : m
 var result: [Int] = []
 for num in 1...max{
 if max % n == 0 && max % m == 0{
 result.append(max)
 }
 max += 1
 }
 while true {
 if n % min == 0 && m % min == 0{
 break
 }
 min -= 1
 }
 var max = n > m ? n : m
 while true {
 if max % n == 0 && max % m == 0{
 break
 }
 max += 1
 }
 
 return [min, max]
 }
 
 solution(3, 12)
 
 
 import Foundation
 
 func solution(_ n:Int) -> Int {
 //3진법으로
 var num = n
 var result: [Int] = []
 while num >= 3 {
 result.append(num % 3)
 num = num / 3
 }
 result.append(num)
 num = 0
 for i in 0...result.count-1 {
 num += Int(pow(3.0,Float(i))) * result[result.count-1-i]
 }
 return 0
 }
 
 solution(45)
 
 import Foundation
 
 func solution(_ n:Int) -> Int {
 var num = n
 var result: [Int] = []
 while num >= 3 {
 result.append(num % 3)
 num = num / 3
 }
 result.append(num)
 num = 0
 for i in 0...result.count-1 {
 num += Int(pow(3.0,Float(i))) * result[result.count-1-i]
 }
 return num
 }
 
 solution(100000000)
 
 
 
 func solution(_ s:String) -> String {
 var arr: [String] = []
 var x = 0
 for i in s {
 if x % 2 == 0 {
 arr.append(String(i.uppercased()))
 } else {
 arr.append(String(i.lowercased()))
 }
 x += 1
 if i == " " {
 x = 0
 }
 }
 return arr.joined()
 }
 
 solution("a b c     ")
 

import Foundation

func solution(_ number:[Int]) -> Int {
    for num in number {
        
    }
    return 0
}

import Foundation

func solution(_ number:[Int]) -> Int {
    var result = 0
    for i in 0...number.count-3 {
        for j in i+1...number.count-2 {
            for k in j+1...number.count-1 {
                if number[i] + number[j] + number[k] == 0 {
                    print(number[i])
                    print(number[j])
                    print(number[k])
                    print("res \(number[i] + number[j] + number[k])")
                    result += 1
                }
            }
        }
    }
    return result
}

print(solution([-2, 3, 0, 2, -5]))




import Foundation

func solution(_ t:String, _ p:String) -> Int {
    var leng = p.count
    var str = t
    var result = 0
    for i in 0...t.count-leng{
        //print(Int(str.suffix(leng))!)
        if Int(str.suffix(leng))! <= Int(p)! {
            result += 1
        }
        str.popLast()
    }
    
    return result
}

solution("10203", "15")


import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    var input: [[Int]] = sizes
    var width: [Int] = []
    var length: [Int] = []
    for var size in input {
        if size[0] < size[1] {
            let temp = size[0]
            size[0] = size[1]
            size[1] = temp
        }
        width.append(size[0])
        length.append(size[1])
    }
    return width.max()! * length.max()!
}

solution([[60, 50], [30, 70], [60, 30], [80, 40]])


func solution(_ s:String, _ n:Int) -> String {
    var charToAscii: [UInt8] = []
    var asciiToChar = ""
    for char in s {
        if 65 <= char.asciiValue! && char.asciiValue! <= 90 {
            if char.asciiValue! + UInt8(n) > 90 {
                charToAscii.append(char.asciiValue! + UInt8(n) - 26)
            } else {
                charToAscii.append(char.asciiValue! + UInt8(n))
            }
        } else if char == " " {
            charToAscii.append(char.asciiValue!)
        } else{
            if char.asciiValue! + UInt8(n) > 122 {
                charToAscii.append(char.asciiValue! + UInt8(n) - 26)
            } else {
                charToAscii.append(char.asciiValue! + UInt8(n))
            }
        }
    }
    //print(charToAscii)
    for asc in charToAscii {
        asciiToChar.append(String(UnicodeScalar(asc)))
    }
    //print(asciiToChar)
    return asciiToChar
}

solution("a B z", 4)
 

import Foundation


func solution(_ s:String) -> Int {
    let dic = ["one": 1, "two": 2, "three": 3, "four": 4,
                              "five": 5, "six": 6, "seven": 7, "eight": 8,
                              "nine": 9, "zero": 0]
    var result: [Int] = []
    var flag: String = ""
    for char in s {
        if let temp = Int(String(char)) {
            result.append(temp)
        } else {
            flag.append(char)
            if dic.keys.contains(flag) {
                result.append(dic[flag]!)
                flag = ""
            }
        }32
    }
    let res = result.map { String($0) }.joined()
    return Int(res)!
}

print(solution("2three45sixseven"))


func solution(_ strings:[String], _ n:Int) -> [String] {
    let sortedString = strings.sorted { first, second  in
        let firstWord = first.index(first.startIndex, offsetBy: n)
        let secondWord = second.index(second.startIndex, offsetBy: n)
        print("\(firstWord)--\(secondWord)")
        if first[firstWord] == second[secondWord] {
            return first < second
        } else {
            return first[firstWord] < second[secondWord]
        }
    }
    
    return sortedString
}

print(solution(["sun", "bed", "car"], 1))


import Foundation

func solution(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var result: [Int] = []
    for command in commands {
        let i = command[0] - 1
        let j = command[1]
        let k = command[2] - 1
        var newCommand = Array(array[i..<j])
        newCommand = newCommand.sorted(by: <)
        result.append(newCommand[k])
    }
    return result
}
print(solution([1, 5, 2, 6, 3, 7, 4], [[2, 5, 3], [4, 4, 1], [1, 7, 3]]))


import Foundation

func solution(_ numbers:[Int]) -> [Int] {
    var res: [Int] = []
    for idx in 0..<numbers.count-1{
        for idx2 in idx+1..<numbers.count{
            print("idx \(numbers[idx]) idx2 \(numbers[idx2])")
            if !res.contains(numbers[idx] + numbers[idx2]){
                print(numbers[idx]+numbers[idx2])
                res.append(numbers[idx] + numbers[idx2])
            }
        }
    }
    res.sort(by: <)
    return res
}

print(solution([2,1,3,4,1]))


import Foundation

func solution(_ s:String) -> [Int] {
    var res: [Int] = []
    var idx = 0
    for char in s {
        var count = 1
        var flag = 0
        print(s.prefix(idx))
        for str in s.prefix(idx).reversed(){
            
            if str == char{
                res.append(count)
                flag = 1
                break
            }
            count += 1
        }
        if flag == 0 {
            res.append(-1)
        }
        idx += 1
    }

    return res
}

func solution2(_ s: String) -> [Int] {
    var word: [String: Int] = [:]
    var result: [Int] = []

    for (index, val) in Array(s).map { String($0) }.enumerated() {
        print("Index: \(index), Value: \(val)")
        
        if let beforeIndex = word[val] {
            
            result.append(index - beforeIndex)
        } else {
            result.append(-1)
        }

        word[val] = index
        print("word \(word)")
    }

    return result
}

print(solution2("foobar"))



import Foundation

func solution(_ food:[Int]) -> String {
    var result: String = ""
    var index = 0
    for dish in food {
        var count = dish / 2
        if dish % 2 != 0 {
            count = (dish - 1) / 2
        }
        print(count)
        for _ in 0..<count {
            result.append(String(index))
        }
        index += 1
    }
    return result + "0" + result.reversed()
}

print(solution([1, 7, 1, 2]))
 */

import Foundation

func solution(_ a:Int, _ b:Int, _ n:Int) -> Int {
    let value = a / b
    print(value)
    var res = 0
    var rest = 0
    let val = n
    let time = 0
    while val > value {
        res += val / value
        rest = val % value
        
    }
    return 0
}

print(solution(2,1,20))
