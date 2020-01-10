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
    
        relation.$match.addObserver(self, id: relation.userId) { (newValue) in
            print("match: ", newValue)
        }
        relation.$match.addObserver(self, id: relation.userId) { (newValue) in
            print("match2: ", newValue)
        }
        relation.alohaGet = true
        relation.match = true


    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
}

