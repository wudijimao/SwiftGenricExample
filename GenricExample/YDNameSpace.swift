//
//  YDNameSpace.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/27.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit



class YDNamespace {
    var control: UIControl
    init(_ control: UIControl) {
        self.control = control
    }
    func testNamespace(){
        print("namespace test")
        print("\(control)")
    }
}

extension UIControl {
    var yd: YDNamespace {
        return YDNamespace(self)
    }
}
