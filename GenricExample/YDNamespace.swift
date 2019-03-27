//
//  YDNamespace.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/27.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit


public protocol YDNameSpaceProtocal {}


public class YDNamespace<Base> {
    var base: Base
    init(_ base: Base) {
        self.base = base
    }
}

extension YDNameSpaceProtocal {
    var yd: YDNamespace<Self> {
        return YDNamespace(self)
    }
}

extension NSObject: YDNameSpaceProtocal {}
