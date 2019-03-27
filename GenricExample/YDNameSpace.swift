//
//  YDNameSpace.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/27.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit



class YDNamespace<T> {
    var base: T
    init(_ base: T) {
        self.base = base
    }
}

extension UIControl {
    var yd: YDNamespace<UIControl> {
        return YDNamespace(self)
    }
}
