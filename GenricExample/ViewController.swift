//
//  ViewController.swift
//  GenricExample
//
//  Created by 吴锡苗 on 2019/3/20.
//  Copyright © 2019 吴锡苗. All rights reserved.
//

import UIKit
private var UIControlEventHandlerKey = "UIControlEventHandlerKey"


public class UIControlEventWrapper<ControlType: UIControl>: NSObject {
    
    private var _handler: (ControlType) -> Void
    
    public init(_ control: ControlType, event: UIControl.Event, handler: @escaping (ControlType) -> Void) {
        self._handler = handler
        super.init()
        control.addTarget(self, action: #selector(invoke(_:)), for: event)
        
    }
    
    @objc private func invoke(_ control: UIControl) {
        self._handler(control as! ControlType)
    }
}

public protocol ExtensionProtocol {}
extension UIControl: ExtensionProtocol{}

public extension ExtensionProtocol where Self: UIControl {
    internal func appendWrapper(_ holder: NSObject) {
        var holders = (objc_getAssociatedObject(self, &UIControlEventHandlerKey) as? [NSObject]) ?? []
        holders.append(holder)
        objc_setAssociatedObject(self, &UIControlEventHandlerKey, holders, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

protocol ThenProtocol {}
extension UIView: ThenProtocol {}

extension ThenProtocol {
    func then(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

class ViewController: UIViewController {
    
    let label = UILabel().then { (make) in
        make.text = "Test Label"
        make.frame = CGRect(x: 200, y: 400, width: 100, height: 100)
    }
    
    let testButton = UIButton(frame: CGRect(x: 200, y: 100, width: 100, height: 100)).then({ make in
        make.setTitle("测试按钮", for: .normal)
        make.backgroundColor = UIColor.red
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(testButton)
        view.addSubview(label)
        label
        
        var count = 0
        testButton.yd.on(.touchUpInside) { (btn) in
            count += 1
            print("按钮被点击\(count)次")
            btn.setTitle("按钮被点击\(count)次", for: .normal)
        }
    }


}

