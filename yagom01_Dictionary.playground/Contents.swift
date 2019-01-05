import Foundation

typealias StringIntDictionary = [String: Int]


var numberForName: [String: Int] = ["yagom" : 100, "chulsoo": 200, "jenny":300]

print(numberForName.isEmpty)
print(numberForName.count

)

print(numberForName["chulsoo"])
print(numberForName["minji"])

numberForName["chulsoo"]=150
print(numberForName["chulsoo"])

numberForName["max"] = 999
print(numberForName["max"])

print(numberForName.removeValue(forKey: "yagom"))

print(numberForName.removeValue(forKey: "yagom"))

print(numberForName["yagom",default:0])
