//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//


let inputView = InputView()
let fileInput = inputView.readFile()

let grammarChecker = GrammarChecker()
var parseTarget = (parseValue: [String](), parseType: Parser.ParseTarget.list)
var convertedValues : JSONData = JSONData.IntegerValue(0)

do {
    parseTarget = try grammarChecker.execute(fileInput)
    convertedValues = try Parser.matchValues(parseTarget)
} catch let error as GrammarChecker.FormatError {
    switch error {
    case .invalidArray:
        print(GrammarChecker.FormatError.invalidArray)
    case .invalidObject:
        print(GrammarChecker.FormatError.invalidObject)
    case .invalidInput:
        print(GrammarChecker.FormatError.invalidInput)
    }
}

let counter = ValueCounter(targetToCount: convertedValues)
let countInfo = counter.makeCountInfo()
let outputView = OutputView()
let resultData = ResultData()
let resultText = resultData.make(convertedValues)
outputView.showResult(countInfo, parseTarget.parseType, text: resultText)




