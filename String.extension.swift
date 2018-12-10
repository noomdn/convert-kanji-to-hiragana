//
//  String.Extension.swift
//  Dictionary
//
//  Created by NoomDN on 10/12/2561 BE.
//  Copyright © 2561 noomdn. All rights reserved.
//

import Foundation

extension String {
    func convertKanjiToHiragana() -> String {
        let input = self.trimmingCharacters(in: .whitespaces)
        var output = ""
        let local = CFLocaleCreate(kCFAllocatorDefault, CFLocaleCreateCanonicalLanguageIdentifierFromString(kCFAllocatorDefault, "ja" as CFString) )
        let range = CFRangeMake(0, input.utf16.count)
        let tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault, input as CFString, range, kCFStringTokenizerUnitWordBoundary, local)
        var tokenType = CFStringTokenizerGoToTokenAtIndex(tokenizer, 0)
        while (tokenType.rawValue != 0) {
            if let text = (CFStringTokenizerCopyCurrentTokenAttribute(tokenizer, kCFStringTokenizerAttributeLatinTranscription) as? NSString).map({ $0.mutableCopy() }) {
                CFStringTransform(text as! CFMutableString, nil, kCFStringTransformLatinHiragana, false)
                output.append(text as! String)
            }
            tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)
        }
        return output
    }
}
