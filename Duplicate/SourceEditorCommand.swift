//
//  SourceEditorCommand.swift
//  Duplicate
//
//  Created by Zheng on 08/05/2018.
//  Copyright © 2018 Zheng. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        // source code from https://www.jianshu.com/p/9c9d0fcc62cc?winzoom=1

        // 第一个选中区域
        let firstSelectObject: XCSourceTextRange = invocation.buffer.selections.firstObject as! XCSourceTextRange
        // 开始复制的行
        let start = firstSelectObject.start.line
        // 结束复制的行
        let end = firstSelectObject.end.line
        // 设置复制的范围
        let rang = NSMakeRange(start, end - start + 1)
        // 插入的内容
        let lines = invocation.buffer.lines.subarray(with: rang)
        // 插入对应行的代码
        let indexSet = IndexSet(integersIn: Range(uncheckedBounds: (lower: end + 1, upper: 2 * end - start + 2)))
        invocation.buffer.lines.insert(lines, at: indexSet)
        
        completionHandler(nil)
    }
    
}
