# Cocos2d-x Lua print 打印问题

新版的 Cocos2d-x 新建 Lua 工程之后你会发现，使用 print 打印居然没有打印信息。
找了一番资料后发现，函数变了。
新版的使用 release_print 这个函数来打印。

下面给大家分享个 print 的小封装