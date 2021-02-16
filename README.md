# dynamicTableView2-iOS
SwipeCellKit 을 활용한 스와이프 가능한 테이블뷰 튜토리얼
> https://github.com/SwipeCellKit/SwipeCellKit

- tableview 와 collectionview 에도 적용이 가능한 'SwipeCellKit'
- swipe과 해당 버튼 클릭을 통해서도 model 의 favorite 과 thumbsup 의 값이 변경
- Feed 모델을 만들어서 vc 와 모델의 역할을 분리해봄

### SwipeCellKit - UITableView
> SwipeCellKit 라이브러리를 활용해서 UITableView 에 코드를 추가해주어야한다.

- nib 파일로 MyTableCell.swift 에 `UITableViewCell 대신 `SwipeTableViewCell` 추가.

Set the `delegate` property on `SwipeTableViewCell`:
```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
    cell.delegate = self
    return cell
}
```

Adopt the `SwipeTableViewCellDelegate` protocol:
```swift
func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
    guard orientation == .right else { return nil }

    let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        // handle action by updating model with deletion
    }

    // customize the action appearance
    deleteAction.image = UIImage(named: "delete")

    return [deleteAction]
}
```

Optionally, you can implement the `editActionsOptionsForRowAt` method to customize the behavior of the swipe actions:
```swift
func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
    var options = SwipeOptions()
    options.expansionStyle = .destructive
    options.transitionStyle = .border
    return options
}
```

### 완성
<p>
<img src ="https://user-images.githubusercontent.com/69136340/108084397-7c336080-70b7-11eb-99c2-67f669c45e5d.png" width="250">
<img src ="https://user-images.githubusercontent.com/69136340/108085567-cff27980-70b8-11eb-890f-a3d42caef7ef.png" width="250">
<img src ="https://user-images.githubusercontent.com/69136340/108085571-d123a680-70b8-11eb-9097-3137bde3947c.png" width="250">
<img src ="https://user-images.githubusercontent.com/69136340/108085573-d1bc3d00-70b8-11eb-908e-c10088a127a5.png" width="250">
<img src ="https://user-images.githubusercontent.com/69136340/108085578-d2ed6a00-70b8-11eb-9752-ffb29e6c6baf.png" width="250"> 
</p>

### 출처
출처ㅣ https://www.youtube.com/watch?v=YaqdoZnRZEE&list=PLgOlaPUIbynoQIcChkQXuGEPXf0Rl8ImH&index=15
 
