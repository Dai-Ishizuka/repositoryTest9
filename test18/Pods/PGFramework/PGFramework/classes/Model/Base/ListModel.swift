//
//  ListModel.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/11/05.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit

// MARK: - Property
public struct ListModel<Element> {
    /*** コンテンツリスト */
    public var contents: [Element] = []
    
    /*** 何個目からの値を取得する数 */
    public var offset: Int = 0
    
    /*** コンテンツの最大数 */
    public var max_count: Int = 0
    
    /*** コンテンツを更に追加するか否か */
    public var loadMore: Bool = false

    public init() {
    }
}

// MARK: - Method
extension ListModel {
    /*** コンテンツに追加 */
    public mutating func insert(_ content: Element) {
        contents += [content]
        offset += 1
    }
    
    /*** コンテンツに追加 at: 追加する場所を指定 */
    public mutating func insert(_ at: UInt) -> Element? {
        if contents.count-1 >= at {
            offset += 1
            return contents[Int(at)]
        }
        return nil
    }
    
    /*** 最後のコンテンツを取得 */
    public mutating func last() -> Element? {
        if let content = contents.popLast() {
            return content
        }
        return nil
    }
    
    /*** 最初のコンテンツを取得 */
    public mutating func first() -> Element? {
        if let content = contents.first {
            return content
        }
        return nil
    }
    
    /*** コンテンツの順番を反転 */
    public mutating func reverse() {
        contents.reverse()
    }
    
    /*** コンテンツを削除 at: 削除する場所を指定 */
    public mutating func remove(at: UInt) -> Element? {
        if contents.count-1 >= at {
            offset -= 1
            return contents.remove(at: Int(at))
        }
        return nil
    }
    
    /*** コンテンツを全て削除 */
    public mutating func removeAll() {
        contents = []
        offset = 0
        loadMore = false
    }
}
