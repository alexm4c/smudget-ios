// (c) 2014 Nate Cook, licensed under the MIT license
//
// Modified by a guy in the comments by alias cwagdev
//
// Fisher-Yates shuffle as top-level functions and array extension methods

import Foundation

extension MutableCollectionType where Self.Index == Int {
    mutating func shuffleInPlace() {
        let c = self.count
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }
}