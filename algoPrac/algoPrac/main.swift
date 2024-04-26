//
//  main.swift
//  algoPrac
//
//  Created by 신지연 on 2024/03/30.
//

import Foundation



func solution(_ n:Int, _ m:Int) -> [Int] {
    //최대공약수
    var max = n > m ? n : m
    while true {
        if max / n == 0 && max / m == 0{
            break
        }
        max += 1
    }
    print(max)
    return []
}

solution(3, 12)


