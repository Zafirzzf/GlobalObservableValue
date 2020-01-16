//
//  ViewController.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/3.
//  Copyright © 2020 周正飞. All rights reserved.
//

import UIKit
struct Person {
    
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        let relation = UserRelation(id: "1")
        let relation2 = UserRelation(id: "2")
        relation2.$match.addObserver(self) { (newValue) in
            print("match2: ", newValue)
        }
        relation2.match = false
        relation.match = true


    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}

