//同步/异步
//GCD、NSOperation
//SDWebImage

//认识网络 概念  原理
//通过网络获取数据，数据的解析--新闻列表
//上传文件/上传数据
//下载文件
//AFN
//综合练习

//1 概念
    //客户端/服务器
    //请求/响应
//2 URL HTTP
//3 请求百度  NSURLConnection -> NSURLRequest -> NSURL
//4 UIWebView
//5 使用浏览器监视请求


//6 网络模型
    //TCP/IP的网络模型  应用层  传输层  网络层  数据链路层
    //传输层  UDP  TCP
    //UDP  无连接，不可靠，速度快，可以发送广播
    //TCP  面向连接，可靠，速度慢，不可以发送广播
//7 Socket

//8 Socket的使用步骤 创建socket 连接服务器 发送数据 接收数据  断开连接
//9 socket的基本演示
//10 模拟聊天

//11 使用Socket发送http请求
    //1 构造http请求头
    //2 发送http请求头
    //3 接收http响应头和响应体
    //4 解析http响应中的响应体

//12 请求头中的 User-Agent   connection
//http/1.0  短连接  当响应结束后连接会立即断开
//http/1.1  长连接  当响应结束后，连接会等待非常短的时间，如果这个时间内没有新的请求，就断开连接

