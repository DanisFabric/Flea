# Flea

Flea 是iOS中对`UIAlertController`的替换方案，提供了友好、灵活的API对用户进行弹框提示。

## 系统需求

- iOS8.0 及以上
- Swift2.2

## 截图

## 安装

### Carthage 

将下面的语句添加到`Cartfile`中，并执行`carthage update`命令

```
github "DanisFabric/Flea"
```

## 使用

### 内置组件

Flea 提供了三种默认的弹框类型，通过enum关联值的特性确定对应的标题和副标题：

1. `ActionSheet(title: String?, subTitle: String?)`：底部弹出框
2. `Alert(title: String?, subTitle: String?)`：用户确认弹框
3. `Notification(title: String?)`：提示栏

示例1，2，3分别对应三种类型的实际效果，`ActionSheet`和`Alert`类型都通过下面语句来添加按钮及响应。

```
func addAction(title: String, color: UIColor = FleaPalette.Blue, action: (() -> Void)?)
	
```

`Notification`类型只运行添加一个按钮和响应，是通过以下代码实现的。

```
func setNotificationAction(title: String, color: UIColor = UIColor.whiteColor(), action: (() -> Void)?)

```

#### 示例代码
##### ActionSheet

```
let defaultActionSheet = Flea(type: .ActionSheet(title: "Do you love Flea", subTitle: "If you love it, you can star Flea on GitHub"))
defaultActionSheet.addAction("Sorry, I don't love it", action: { 
	// Call this after tap button         
})
defaultActionSheet.addAction("I love it!", action: { 
	// Call this after tap button
})
defaultActionSheet.show()

```