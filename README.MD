### `ZXWinnerScrollView`

>
滚动中奖名单

#### `IMG`

|IMG|
|---|
|![IMG](https://github.com/iFallen/ZXWinnerScrollView/raw/master/img.gif)|

#### `CODE`

```
let winnerList = ZXWinnerScrollView.init(origin: CGPoint(x: 30, y: 100), width: UIScreen.main.bounds.size.width - 60, pageSize: 6)
winnerList.layer.borderColor = UIColor.orange.cgColor
winnerList.layer.borderWidth = 1
winnerList.reloadData(["1","2","3","4","5","6","7","8","9","10","11","12","13","14"])
self.view.addSubview(winnerList)

```