//
//  ViewController.swift
//  DynamicTableViewTutorial
//
//  Created by kimhyungyu on 2021/01/07.
//

import UIKit
import SwipeCellKit

let MY_TABLE_VIEW_CELL_ID = "myTableViewCell"

//피드 데이터 모델
class Feed {
    let content: String
    var isFavorite: Bool = false
    var isThumbsUp: Bool = false
    //생성자
    init(content: String) {
        self.content = content
        
    }
}

class ViewController: UIViewController {
    
    let contentArray = [
        Feed(content: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters"),
        Feed(content: "There are many variations of passages of Lorem Ipsum available"),
        Feed(content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
        Feed(content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.")
    ]

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
        //데이터와 UI 연결
        if self.contentArray.count>0 {
            //기존에는 여기서 바로 contentArray 의 내용을 넣어주었다.
//            cell.userContentLabel.text = contentArray[indexPath.row]
            //만든 모델자체를 cell 에 넣어준다. cell vc 에서는 모델을 가지고 ui로 표현.
            cell.feedData = contentArray[indexPath.row]

        }
        
        return cell
    }
}

//MARK: - SwipeTableViewDelegate
extension ViewController: SwipeTableViewCellDelegate {
    //셀에 대한 스와이프 액션.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        // 데이터
        let dataItem = contentArray[indexPath.row] as Feed
        // 셀
        let cell = tableView.cellForRow(at: indexPath) as! MyTableViewCell
        //액션 방향에 따른 분기 처리
        switch orientation {
        case .left:
            let thumbsUpAction = SwipeAction(style: .default, title: "추천", handler: { action, indexPath in
                print("thumbsUpAction come")
            })
            
            // customize the action appearance
            thumbsUpAction.image = UIImage(systemName: "hand.thumbsup.fill")
            thumbsUpAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            
            return [thumbsUpAction]
        case .right:
            let heartAction = SwipeAction(style: .default, title: "좋아요", handler: { action, indexPath in
                print("heartAction come")
            })
            // customize the action appearance
            heartAction.image = UIImage(systemName: "heart.fill")
            heartAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            return [heartAction]
        }
        
        
//        guard orientation == .right else { return nil }
//
//          let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//              // handle action by updating model with deletion
//          }
//
//          // customize the action appearance
//          deleteAction.image = UIImage(named: "delete")
//
//          return [deleteAction]
    }
    //셀 액션에 대한 옵션 설정
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        
        //액션에 대한 옵션이 구체적으로 들어감.
        options.expansionStyle = .selection
        options.transitionStyle = .border
        
        return options
        }
    }


