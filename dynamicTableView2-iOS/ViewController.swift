//
//  ViewController.swift
//  DynamicTableViewTutorial
//
//  Created by kimhyungyu on 2021/01/07.
//

import UIKit
import SwipeCellKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //셀 리소스 파일 가져오기
        //let myTableViewCellNib = UINib(nibName: "MyTableViewCell", bundle: nil)
        let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
        
        //셀에 리소스 등록
        self.myTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        
        //아주 중요
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        
        
    }
}

//extension
extension ViewController: UITableViewDelegate{}
extension ViewController: UITableViewDataSource{
    //테이블 뷰 셀의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    //각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        cell.delegate = self
        
        cell.userContentLabel.text = contentArray[indexPath.row]
        
        return cell
    }
}

//MARK: - SwipeTableViewDelegate
extension ViewController: SwipeTableViewCellDelegate {
    //셀에 대한 스와이프 액션.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
              // handle action by updating model with deletion
          }

          // customize the action appearance
          deleteAction.image = UIImage(named: "delete")

          return [deleteAction]
    }
    //셀 액션에 대한 옵션 설정
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        //액션에 대한 옵션이 구체적으로 들어감.
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        
        return options
        }
    }


