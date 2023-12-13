# VimScript 速查表

譯註：折騰 Vim 當然要能看懂和改寫相關腳本，而中文資料匱乏，缺一個提綱挈領的教程。本文翻譯自 Andrew Scala 的 《[Five Minute Vimscript](http://andrewscala.com/vimscript/)》，立足於讓你用最短的時間掌握 VimScript 的基礎和要點，你可以把它看成一份語言速查表。

Vim有著豐富的內建文檔系統，使用 `:h <關鍵詞>` 就可以閱讀，如果你想在方便的嘗試各種 vimscript ，你可以通過 NORMAL 模式下使用 `gQ` 命令進入 VimScript 的交互式環境調試命令。

注意：下面的例子中會包含一些形如 `<符號>` 的符號，意味著正式使用時應該被完全替換成真實的東西，包括左右兩邊的尖括號。而單獨的 `<` 和 `>` 在 VimScript 中被用作比較符號。

## 變量

- `let` 命令用來對變量進行初始化或者賦值。
- `unlet` 命令用來刪除一個變量。
- `unlet!` 命令同樣可以用來刪除變量，但是會忽略諸如變量不存在的錯誤提示。

默認情況下，如果一個變量在函數體以外初始化的，那麼它的作用域是全局變量；而如果它是在函數體以內初始化的，那它的作用於是局部變量。同時你可以通過變量名稱前加冒號前綴明確的指明變量的作用域：

```text
g:var - 全局
a:var - 函數參數
l:var - 函數局部變量
b:var - buffer 局部變量
w:var - window 局部變量
t:var - tab 局部變量
s:var - 當前腳本內可見的局部變量
v:var - Vim 預定義的內部變量
```

你可以通過 $name 的模式讀取或者改寫環境變量，同時可以用 &option 的方式來讀寫 vim 內部的設置值。


## 數據類型

**Number**：32 位有符號整數

```VimL
-123
0x10
0177
```

**Float**: 浮點數，需要編譯 Vim 的時候，有 `+float` 特性支持

```VimL
123.456
1.15e-6
-1.1e3
```

**String**: NULL 結尾的 8位無符號字符串

```VimL
"ab\txx\"--"
'x-z''a,c'
```

**Funcref**: 函數引用，函數引用類型的變量名必須以大寫字母開頭

```VimL
:let Myfunc = function("strlen")
:echo Myfunc('foobar') " Call strlen on 'foobar'.
6
```

**List**: 有序列表

```VimL
:let mylist = [1, 2, ['a', 'b']]
:echo mylist[0]
1
:echo mylist[2][0]
a
:echo mylist[-2]
2
:echo mylist[999]
E684: list index out of range: 999
:echo get(mylist, 999, "THERE IS NO 1000th ELEMENT")
THERE IS NO 1000th ELEMENT
```

**Dictionary**: 無序的 Key/Value 容器

```VimL
:let mydict = {'blue': "#0000ff", 'foo': {999: "baz"}}
:echo mydict["blue"]
#0000ff
:echo mydict.foo
{999: "baz"}
:echo mydict.foo.999
baz
:let mydict.blue = "BLUE"
:echo mydict.blue
BLUE
```

沒有布爾類型，整數 0 被當作假，其他被當作真。字符串在比較真假前會被轉換成整數，大部分字符串都會被轉化為 0，除非以非零開頭的字符串才會轉化成非零。

（譯註：可以調用 type(varname) 來取得變量的類型，最新版 Vim 8.1 中已經包含 Boolean 類型，並且有 v:true, v:false  兩個值）

VimScript 的變量屬於動態弱類型。

```VimL
:echo 1 . "foo"
1foo
:echo 1 + "1"
2

:function! TrueFalse(arg)
:   return a:arg? "true" : "false"
:endfunction

:echo TrueFalse("foobar")
false
:echo TrueFalse("1000")
true
:echo TrueFalse("x1000")
false
:echo TrueFalse("1000x")
true
:echo TrueFalse("0")
false
```

## 字符串比較

- `<string>` == `<string>`: 字符串相等
- `<string>` != `<string>`: 字符串不等
- `<string>` =~ `<pattern>`: 匹配 pattern
- `<string>` !~ `<pattern>`: 不匹配 pattern
- `<operator>#`: 匹配大小寫
- `<operator>?`: 不匹配大小寫

注意：設置選項 `ignorecase` 會影響 == 和 != 的默認比較結果，可以在比較符號添加 ? 或者 # 來明確指定大小寫是否忽略。


`<string>` . `<string>`: 字符串鏈接

```VimL
:function! TrueFalse(arg)
:   return a:arg? "true" : "false"
:endfunction

:echo TrueFalse("X start" =~ 'X$')
false
:echo TrueFalse("end X" =~ 'X$')
true
:echo TrueFalse("end x" =~# 'X$')
false
```

## If, For, While, and Try/Catch

條件判斷：

```VimL
if <expression>
    ...
elseif <expression>
    ...
else
    ...
endif
```

循環：

```VimL
for <var> in <list>
    continue
    break
endfor
```

複雜循環：

```VimL
for [var1, var2] in [[1, 2], [3, 4]]
    " on 1st loop, var1 = 1 and var2 = 2
    " on 2nd loop, var1 = 3 and var2 = 4
endfor
```

While 循環：

```VimL
while <expression>
endwhile
```

異常捕獲：

```VimL
try
    ...
catch <pattern (optional)>
    " HIGHLY recommended to catch specific error.
finally
    ...
endtry
```

## 函數

使用 `function` 關鍵字定義一個函數，使用 `function!` 覆蓋一個函數的定義，函數和變量一樣也有作用範圍的約束。需要注意函數名必須以大寫字母開頭。

```VimL
function! <Name>(arg1, arg2, etc)
    <function body>
endfunction
```

`delfunction <function>` 刪除一個函數

`call <function>` 調用一個函數，函數調用前的 call 語句是必須的，除非在一個表達式裡。

例如：強制創建一個全局函數（使用感歎號），參數使用 `...` 這種不定長的參數形式時，a:1 表示 `...` 部分的第一個參數，a:2 表示第二個，如此類推，a:0 用來表示 `...` 部分一共有多少個參數。

```VimL
function! g:Foobar(arg1, arg2, ...)
    let first_argument = a:arg1
    let index = 1
    let variable_arg_1 = a:{index} " same as a:1
    return variable_arg_1
endfunction
```

有一種特殊的調用函數的方式，可以指明該函數作用的文本區域是從當前緩衝區的第幾行到第幾行，按照 `1,3call Foobar()` 的格式調用一個函數的話，該函數會在當前文件的第一行到第三行每一行執行一遍，再這個例子中，該函數總共被執行了三次。

如果你在函數聲明的參數列表後添加一個 `range` 關鍵字，那函數就只會被調用一次，這時兩個名為 `a:firstline` 和 `a:lastline` 的特殊變量可以用在該函數內部使用。

例如：強制創建一個名為 `RangeSize` 的函數，用來顯示被調用時候的文本範圍：

```VimL
function! b:RangeSize() range
    echo a:lastline - a:firstline
endfunction
```

## 面向對像

Vim 沒有原生的類的支持，但是你可以用字典模擬基本的類。為了定義一個類的方法，可以在函數聲明時使用 `dict` 關鍵字來將內部字典暴露為 `self` 關鍵字：

```VimL
let MyClass = {"foo": "Foo"}
function MyClass.printFoo() dict
    echo self.foo
endfunction
```

類的實現更類似於 singleton，為了在 VimScript 中創建類的實例，我們對字典使用 `deepcopy()` 方法進行拷貝：

```VimL
:let myinstance = deepcopy(MyClass)
:call myinstance.printFoo()
Foo
:let myinstance.foo = "Bar"
:call myinstance.printFoo()
Bar
```

## 接下來做什麼？

現在既然你已經知道了大致原理，下面給你推薦一些好的資源

教程:

- [Vim 中文幫助文檔（usr_41） - 編寫 Vim 腳本和 API 列表](http://vimcdoc.sourceforge.net/doc/usr_41.html)
- [Vim 腳本指北](https://github.com/lymslive/vimllearn)
- [Vim 腳本開發規範](https://github.com/vim-china/vim-script-style-guide)

其他:

- [知乎：Vim 專欄](https://zhuanlan.zhihu.com/vimrc)


## 感謝

希望你覺得本文對你有用，感謝閱讀。
