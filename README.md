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
notificationFlea.baseAt(navigationCotnroller: navigationController!).stay(2).show()
```