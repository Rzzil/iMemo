//
//  MainViewController.swift
//  iMemo
//
//  Created by Zihao Yan,Kang Xie,Tianqi Fu on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ResetToDefault(_ sender: Any) {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        print("Reset complete!")
    }
}
