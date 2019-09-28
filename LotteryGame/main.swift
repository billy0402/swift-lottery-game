//
//  main.swift
//  LotteryGame
//
//  Created by User on 2019/7/18.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation

func input() -> String {
    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    var inputStr = String(data: inputData, encoding: .utf8)!
    inputStr.removeLast() //去掉\n
    print("你輸入了 \(inputStr.debugDescription)")
    
    return inputStr
}

func toInt(_ inputStr: String) -> Int? {
    guard let strInt = Int(inputStr) else {
        print("輸入錯誤，請重新輸入")
        return nil
    }
    
    return strInt
}

func autoRamdom() -> Array<Int> {
    var ramdomSet = Set<Int>()
    while ramdomSet.count < 6 {
        let number = Int.random(in: 1...49)
        ramdomSet.insert(number)
    }
    
    return ramdomSet.sorted()
}

func manualNum() -> Array<Int> {
    var inputSet = Set<Int>()
    
    print("請一次輸入一個 1~49 之間的數字")
    while inputSet.count < 6 {
        print("輸入你的號碼")
        let inputStr = input()
        
        if let inputNum = toInt(inputStr) {
            if inputNum >= 1 && inputNum <= 49 {
                if !inputSet.insert(inputNum).inserted {
                    print("輸入重複，請重新輸入")
                }
            } else {
                print("超出範圍，請重新輸入")
            }
        }
    }
    
    return inputSet.sorted()
}

func game(_ chooseMode: String) {
    let autoArray = autoRamdom()
    var userArray = Array<Int>()
    var checkArray = Array<Int>()
    
    if chooseMode == "a" {
        print("自動選號模式")
        userArray = autoRamdom()
    } else if chooseMode == "m" {
        print("手動選號模式")
        userArray = manualNum()
    }
    
    for number in userArray {
        if autoArray.contains(number) {
            checkArray.append(number)
        }
    }
    
    print("中獎號碼: \(autoArray)")
    print("你的號碼: \(userArray)")
    print("有中號碼: \(checkArray)")
    
    if userArray == autoArray {
        print("恭喜中獎")
    } else {
        print("銘謝惠顧")
    }
    
    print("------------------------------")
}

print("樂透遊戲")

print("請輸入 a(自動) 或 m(手動)")
var chooseMode: String
repeat {
    chooseMode = input()
    if chooseMode != "a" && chooseMode != "m" {
        print("輸入錯誤，請重新輸入")
    }
} while chooseMode != "a" && chooseMode != "m"

print("請輸入遊戲次數，一個 1~10 之間的數字")
var gameTimes: Int?
repeat {
    gameTimes = toInt(input())
    if gameTimes != nil {
        if gameTimes! < 1 || gameTimes! > 10 {
            print("超出範圍，請重新輸入")
            gameTimes = nil
        }
    }
} while gameTimes == nil

for times in 1...gameTimes! {
    print("第 \(times) 次遊戲")
    game(chooseMode)
}

print("結束遊戲")
