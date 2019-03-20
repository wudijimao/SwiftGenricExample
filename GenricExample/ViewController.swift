//
//  ViewController.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/20.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit
private var UIControlEventHandlerKey = "UIControlEventHandlerKey"


public class UIControlEventWrapper: NSObject {
    
    private var _handler: (UIControl) -> Void
    
    public init(_ control: UIControl, event: UIControl.Event, handler: @escaping (UIControl) -> Void) {
        self._handler = handler
        super.init()
        control.addTarget(self, action: #selector(invoke(_:)), for: event)
        
    }
    
    @objc private func invoke(_ control: UIControl) {
        self._handler(control)
    }
}

public extension UIControl {
    
    fileprivate func appendWrapper(_ holder: NSObject) {
        var holders = (objc_getAssociatedObject(self, &UIControlEventHandlerKey) as? [NSObject]) ?? []
        holders.append(holder)
        objc_setAssociatedObject(self, &UIControlEventHandlerKey, holders, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    public func on(_ event: UIControl.Event, _ handler: @escaping (UIControl)-> Void) {
        let eventWrapper = UIControlEventWrapper.init(self, event: event, handler: handler)
        self.appendWrapper(eventWrapper)
    }
}


class ViewController: UIViewController {
    
    let testButton = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testButton)
        testButton.setTitle("测试按钮", for: .normal)
        testButton.backgroundColor = UIColor.red
        var count = 0
        testButton.on(.touchUpInside) { (_) in
            count += 1
            print("按钮被点击\(count)次")
        }
    }


}

