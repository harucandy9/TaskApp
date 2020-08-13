//
//  InputViewController.swift
//  taskapp
//
//  Created by h_nagao on 2020/08/08.
//  Copyright © 2020 haruka.nagao. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = task.title
        contentTextView.text = task.contents
        datePicker.date = task.date

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write{
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentTextView.text
            self.task.date = self.datePicker.date
            self.realm.add(self.task, update: .modified)
        }
        
        setNotification(task: task) //ローカル通知の際に追加
        
        super.viewWillDisappear(animated)
    }
    
    //タスクのローカル通知を登録する
    func setNotification(task: Task){
        let content = UNMutableNotificationContent()
        //タイトルと内容の設定
        if task.title == "" {
            content.title = "(タイトル無し)"
        }else{
            content.title = task.title
        }
        if task.contents == "" {
            content.body = "(内容無し)"
        }else{
            content.body = task.contents
        }
    }
    
    @objc func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
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
