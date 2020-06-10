//
//  RecordViewController.swift
//  iMemo
//
//  Created by Rzzil on 2020/6/10.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "iphone"
        //cell = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return cell
    }
    

    let recorder = RecordManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func StartRecording(_ sender: Any) {
        recorder.beginRecord()
    }
    
    @IBAction func StopRecording(_ sender: Any) {
        recorder.stopRecord()
    }
    
    @IBAction func Play(_ sender: Any) {
        recorder.play()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
