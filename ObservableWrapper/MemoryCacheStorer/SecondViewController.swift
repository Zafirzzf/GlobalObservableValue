//
//  SecondViewController.swift
//  ObservableWrapper
//
//  Created by 周正飞 on 2020/1/4.
//  Copyright © 2020 周正飞. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let user = UserRelation(id: "2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        user.$match.addObserver(self) { (newName) in
            print("Second: ", newName)
        }
    }
}
