//
//  speechConvertViewController.swift
//  iMemo
//
//  Created by admin on 10/6/20.
//  Copyright © 2020 Enterprise. All rights reserved.
//

import UIKit
import Speech

class speechConvertViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let manager = FileManager.default
    let url = NSHomeDirectory() + "/Documents/"
    
    var cintents1 = [String]()
    var currentCell: UITableViewCell?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cintents1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        if(indexPath.row != 0)
        {
            cell.textLabel?.text = cintents1[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentCell = tableView.cellForRow(at: indexPath)
        print("测试:" + (currentCell?.textLabel?.text ?? ""))
    }
    
        
    @IBOutlet weak var convertSpeech: UIButton!
    @IBOutlet weak var convertedText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let domain = Bundle.main.bundleIdentifier!
        //        UserDefaults.standard.removePersistentDomain(forName: domain)
                print("地址："+url)
                do
                {
                    cintents1 = try manager.contentsOfDirectory(atPath: url)
                    print("cintents:\(cintents1)\n")
                } catch{
                    print("Error occurs.")
                }
                
                // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
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
