//
//  YDNamespace.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/28.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit

class YDNamespace<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

public protocol YDNameSpaceProtocal {}
extension NSObject: YDNameSpaceProtocal {}

extension YDNameSpaceProtocal  {
    var yd: YDNamespace<Self> {
        return YDNamespace<Self>(self)
    }
}

extension YDNamespace where Base: UIView {
    var size: CGSize {
        return base.frame.size
    }
}

extension YDNamespace where Base: UIControl {
    
    func on(_ event: UIControl.Event, _ handler: @escaping (Base)-> Void) {
        let eventWrapper = UIControlEventWrapper.init(base, event: event, handler: handler)
        base.appendWrapper(eventWrapper)
    }
}
