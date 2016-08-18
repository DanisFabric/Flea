# Flea

Flea 是iOS中对`UIAlertController`的替换方案，提供了友好、灵活的API对用户进行弹框提示。

## 系统需求

- iOS8.0+
- Swift 2.2+

## 截图

## 安装

### Carthage 

将下面的语句添加到`Cartfile`中，并执行`carthage update`命令

```ogdl
$ github "DanisFabric/Flea"
```

## 使用

### ActionSheet

```swift
let actionFlea = Flea(type: .ActionSheet(title: "Do you love Flea", subTitle: "If you love it, you can star Flea on GitHub"))
actionFlea.titleColor = FleaPalette.DarkGray
actionFlea.subTitleColor = FleaPalette.Green
actionFlea.addAction("Sorry, I don't love it", color: FleaPalette.Blue, action: { 
	//        
})
actionFlea.addAction("I love it", color: FleaPalette.Red, action: { 
	//           
})
actionFlea.show()

```

### Alert

```swift
let alert = Flea(type: .Alert(title: "Do you love Flea", subTitle: "If you love Flea, you may start it on GitHub"))
alert.addAction("No, thanks", action: { 
                
})
alert.addAction("I love Flea", action: { 
                
})
alert.addAction("What is Flea", color: FleaPalette.Red, action: { 
                
})
alert.show()
```

### notification 

```swift
let notificationFlea = Flea(type: .Notification(title: "Hello, welcome to use Flea"))
notificationFlea.setNotificationAction("Thanks", action: { 
                
})
notificationFlea.baseAt(navigationCotnroller: navigationController!).stay(2).show()
```
### 自定义

Flea 十分灵活，用户能够填充任意的View，依托于Flea弹框展示。你可以通过众多参数来配置Flea的行为。

#### Direction

Direction决定从弹框从哪个方向进入屏幕

```swift
flea.direction = .Top // 默认

public enum Direction {
    case Top
    case Left
    case Bottom
    case Right
}

```

#### Achor

Anchor 决定弹框显示的位置

```swift
flea.anchor = .Edge // 默认

public enum Anchor {
    case Edge		// 贴边
    case Center		// 停留在中间
}
```

#### Style

Style 是弹框的显示风格

```swift
flea.stype = .Normal(UIColor.WhiteColor())		// 默认

public enum FleaStyle {
    case Normal(UIColor)				// 纯色
    case Blur(UIBlurEffectStyle)	// 模糊
}
```

#### BackgroundStyle

BackgroundStyle 决定弹框是时的背景样式
```swift
flea.backgroundStyle = .Clear		//默认

public enum FleaBackgroundStyle {
    case Dark		// 暗色阴影
    case Clear		// 透明，不能点击背景后的组件
    case None		// 透明，可以透过背景点
}
```

#### 其他

* cornerRadius: 弹出框的圆角大小， 默认为0
* duration: 弹框停留时长，时间超过duration，弹框自动消失。默认为0，不会 自动消失
* 