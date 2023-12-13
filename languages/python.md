Python 速查表中文版
===

- 本手冊是 [Python cheat sheet](http://datasciencefree.com/python.pdf) 的中文翻譯版。原作者：Arianne Colton and Sean Chen(data.scientist.info@gmail.com)
- 編譯：[ucasFL](https://github.com/ucasFL)

## 目錄

- [常規](#常規)
- [數值類類型](#數值類類型)
- [數據結構](#數據結構)
- [函數](#函數)
- [控制流](#控制流)
- [面向對像編程](#面向對像編程)
- [常見字符串操作](#常見字符串操作)
- [異常處理](#異常處理)
- [列表、字典以及元組的推導表達式](#列表、字典以及元組的推導表達式)
- [單元測試](#單元測試)

## 常規

- Python 對大小寫敏感
- Python 的索引從 0 開始
- Python 使用空白符（製表符或空格）來縮進代碼，而不是使用花括號

### 獲取幫助

- 獲取主頁幫助：`help()`
- 獲取函數幫助：`help(str.replace)`
- 獲取模塊幫助：`help(re)`

### 模塊(庫)

Python的模塊只是一個簡單地以 `.py` 為後綴的文件。

- 列出模塊內容：`dir(module1)`
- 導入模塊：`import module`
- 調用模塊中的函數：`module1.func1()`

> **注**：`import`語句會創建一個新的命名空間(namespace)，並且在該命名空間內執行`.py`文件中的所有語句。如果你想把模塊內容導入到當前命名空間，請使用`from module1 import *`語句。

## 數值類類型

查看變量的數據類型：`type(variable)`

### 六種經常使用的數據類型

1. **int/long**：過大的 `int` 類型會被自動轉化為 `long` 類型

2. **float**：64 位，Python 中沒有 `double` 類型

3. **bool**：真或假

4. **str**：在 Python 2 中默認以 ASCII 編碼，而在 Python 3 中默認以 Unicode 編碼

    - 字符串可置於單/雙/三引號中
    - 字符串是字符的序列，因此可以像處理其他序列一樣處理字符串
    - 特殊字符可通過 `\` 或者前綴 `r` 實現：

        ```python
        str1 = r'this\f?ff'
        ```

    - 字符串可通過多種方式格式化：

        ```python
        template = '%.2f %s haha $%d';
        str1 = template % (4.88, 'hola', 2)
        ```

5. **NoneType(None)**：Python 「null」值（`None`對像**只**存在一個實例）

    - `None`不是一個保留關鍵字，而是`NoneType`的一個唯一實例
    - `None`通常是可選函數參數的默認值：

        ```python
        def func1(a, b, c=None)
        ```

    - `None`的常見用法：

        ```python
        if variable is None :
        ```

6. **datetime**：Python內置的`datetime`模塊提供了`datetime`、`data`以及`time`類型。

    - `datetime`組合了存儲於`date`和`time`中的信息

    ```python
    # 從字符串中創建 datetime
    dt1 = datetime.strptime('20091031', '%Y%m%d')
    # 獲取 date 對像
    dt1.date()
    # 獲取 time 對像
    dt1.time()
    # 將 datetime 格式化為字符串
    dt1.strftime('%m/%d/%Y%H:%M')
    # 更改字段值
    dt2 = dt1.replace(minute=0, second=30)
    # 做差, diff 是一個 datetime.timedelta 對像
    diff = dt1 - dt2
    ```

> **注**：
> - `str`、`bool`、`int`和`float`同時也是顯式類型轉換函數。
> - 除字符串和元組外，Python 中的絕大多數對象都是可變的。

## 數據結構

> **注**：所有的「非只讀(non-Get)」函數調用，比如下面例子中的`list1.sort()`，除非特別聲明，都是原地操作(不會創建新的對象)。

### 元組

元組是 Python 中任何類型的對象的一個一維、固定長度、**不可變**的序列。

```python
# 創建元組
tup1 = 4, 5, 6
tup1 = (6, 7, 8)
# 創建嵌套元組
tup1 = (4, 5, 6), (7, 8)
# 將序列或迭代器轉化為元組
tuple([1, 0, 2])
# 連接元組
tup1 + tup2
# 解包元組
a, b, c = tup1
```

**元組應用**：

```python
# 交換兩個變量的值
a, b = b, a
```

### 列表

列表是 Python 中任何類型的對象的一個一維、非固定長度、**可變**（比如內容可以被修改）的序列。

```python
# 創建列表
list1 = [1, 'a', 3]
list1 = list(tup1)
# 連接列表
list1 + list2
list1.extend(list2)
# 追加到列表的末尾
list1.append('b')
# 插入指定位置
list1.insert(PosIndex, 'a')
# 反向插入，即彈出給定位置的值/刪除
ValueAtIdx = list1.pop(PosIndex)
# 移除列表中的第一個值, a 必須是列表中第一個值
list1.remove('a')
# 檢查成員
3 in list1 => True or False
# 對列表進行排序
list1.sort()
# 按特定方式排序
list1.sort(key=len) # 按長度排序
```

> - 使用 + 連接列表會有比較大的開支，因為這個過程中會創建一個新的列表，然後複製對象。因此，使用`extend()`是更明智的選擇。
> - `insert`和`append`相比會有更大的開支（時間/空間）。
> - 在列表中檢查是否包含一個值會比在字典和集合中慢很多，因為前者需要進行線性掃瞄，而後者是基於哈希表的，所以只需要花費常數時間。

#### 內置的`bisect`模塊

- 對一個排序好的列表進行二分查找或插入
- `bisect.bisect`找到元素在列表中的位置，`bisect.insort`將元素插入到相應位置。
- 用法：

    ```python
    import bisect
    list1 = list(range(10))
    #找到 5 在 list1 中的位置，從 1 開始，因此 position = index + 1
    bisect.bisect(list1, 5)
    #將 3.5 插入 list1 中合適位置
    bisect.insort(list1, 3.5)
    ```

> **注**：`bisect` 模塊中的函數並不會去檢查列表是否排序好，因為這會花費很多時間。所以，對未排序好的列表使用這些函數也不會報錯，但可能會返回不正確的結果。

### 針對序列類型的切片

> 序列類型包括`str`、`array`、`tuple`、`list`等。

用法：

```python
list1[start:stop]
# 如果使用 step
list1[start:stop:step]
```

> **注**：
> - 切片結果包含 `start` 索引，但不包含 `stop` 索引
> - `start/stop` 索引可以省略，如果省略，則默認為序列從開始到結束，如 `list1 == list1[:]` 。

`step` 的應用：

```python
# 取出奇數位置的元素
list1[::2]
# 反轉字符串
str1[::-1]
```

### 字典（哈希表）

```python
# 創建字典
dict1 = {'key1': 'value1', 2: [3, 2]}
# 從序列創建字典
dict(zip(KeyList, ValueList))
# 獲取/設置/插入元素
dict1['key1']
dict1['key1'] = 'NewValue'
# get 提供默認值
dict1.get('key1', DefaultValue)
# 檢查鍵是否存在
'key1' in dict1
# 獲取鍵列表
dict1.keys()
# 獲取值列表
dict1.values()
# 更新值
dict1.update(dict2)  # dict1 的值被 dict2 替換
```

> - 如果鍵不存在，則會出現 `KeyError Exception` 。
> - 當鍵不存在時，如果 `get()`不提供默認值則會返回 `None` 。
> - 以相同的順序返回鍵列表和值列表，但順序不是特定的，也就是說極大可能非排序。

#### 有效字典鍵類型

- 鍵必須是不可變的，比如標量類型(`int`、`float`、`string`)或者元組（元組中的所有對象也必須是不可變的）。
- 這兒涉及的技術術語是「可哈希(hashability)」。可以用函數`hash()`來檢查一個對象是否是可哈希的，比如 `hash('This is a string')`會返回一個哈希值，而`hash([1,2])`則會報錯（不可哈希）。

### 集合

- 一個集合是一些**無序**且唯一的元素的聚集；
- 你可以把它看成只有鍵的字典；

    ```python
    # 創建集合
    set([3, 6, 3])
    {3, 6, 3}
    # 子集測試
    set1.issubset(set2)
    # 超集測試
    set1.issuperset(set2)
    # 測試兩個集合中的元素是否完全相同
    set1 == set2
    ```

- **集合操作**
  - 並（或）：`set1 | set2`
  - 交（與）：`set1 & set2`
  - 差：`set1 - set2`
  - 對稱差（異或）：`set1 ^ set2`

## 函數

Python 的函數參數傳遞是通過**引用傳遞**。

- 基本形式

    ```python
    def func1(posArg1, keywordArg1=1, ..)
    ```

    > **注**：
    > - 關鍵字參數必須跟在位置參數的後面；
    > - 默認情況下，Python 不會「延遲求值」，表達式的值會立刻求出來。

- 函數調用機制

    1. 所有函數均位於模塊內部作用域。見「模塊」部分。
    1. 在調用函數時，參數被打包成一個元組和一個字典，函數接收一個元組`args`和一個字典`kwargs`，然後在函數內部解包。

- 「函數是對像」的常見用法：

    ```python
    def func1(ops = [str.strip, user_define_func, ..], ..):
        for function in ops:
            value = function(value)
    ```

### 返回值

- 如果函數直到結束都沒有`return`語句，則返回`None`。
- 如果有多個返回值則通過**一個**元組來實現。

    ```python
    return (value1, value2)
    value1, value2 = func1(..)
    ```

### 匿名函數（又稱 LAMBDA 函數）

- 什麼是匿名函數？

    匿名函數是一個只包含一條語句的簡單函數。

    ```python
    lambda x : x * 2
    # def func1(x) : return x * 2
    ```

- 匿名函數的應用：「柯裡化(curring)」，即利用已存在函數的部分參數來派生新的函數。

    ```python
    ma60 = lambda x : pd.rolling_mean(x, 60)
    ```

### 一些有用的函數（針對數據結構）

1. **Enumerate** 返回一個序列`(i, value)`元組，`i` 是當前 `item` 的索引。

    ```python
    for i, value in enumerate(collection):
    ```

    - 應用：創建一個序列中值與其在序列中的位置的字典映射（假設每一個值都是唯一的）。

1. **Sorted** 可以從任意序列中返回一個排序好的序列。

    ```python
    sorted([2, 1, 3]) => [1, 2, 3]
    ```

    - 應用：

        ```python
        sorted(set('abc bcd')) => [' ', 'a', 'b', 'c', 'd']
        # 返回一個字符串排序後無重複的字母序列
        ```

1. **Zip** 函數可以把許多列表、元組或其他序列的元素配對起來創建一系列的元組。

    ```python
    zip(seq1, seq2) => [('seq1_1', 'seq2_1'), (..), ..]
    ```

    - `zip()`可以接收任意數量的序列作為參數，但是產生的元素的數目取決於最短的序列。

    - 應用：多個序列同時迭代：

        ```python
        for i, (a, b) in enumerate(zip(seq1, seq2)):
        ```

    - `unzip`：另一種思考方式是把一些行轉化為一些列：

        ```python
        seq1, seq2 = unzip(zipOutput)
        ```

1. **Reversed** 將一個序列的元素以逆序迭代。

    ```python
    list(reversed(range(10)))
    ```

    > `reversed()` 會返回一個迭代器，`list()` 使之成為一個列表。

## 控制流

1. 用於 `if-else` 條件中的操作符：

    ```python
    var1 is var2  # 檢查兩個變量是否是相同的對象

    var1 is not var2  # 檢查兩個變量是否是不同的對象

    var1 == var2  # 檢查兩個變量的值是否相等
    ```

    > **注**：Python 中使用 `and`、`or`、`not` 來組合條件，而不是使用 `&&`、`||`、`!` 。

1. `for`循環的常見用法：

    ```python
    for element in iterator:  # 可迭代對像（list、tuple）或迭代器
        pass

    for a, b, c in iterator:  # 如果元素是可以解包的序列
        pass
    ```

1. `pass`：無操作語句，在不需要進行任何操作的塊中使用。
1. 三元表達式，又稱簡潔的 `if-else`，基本形式：

    ```python
    value = true-expr if condition else false-expr
    ```

1. Python 中沒有 `switch/case` 語句，請使用 `if/elif`。

## 面向對像編程

1. **對像**是 Python 中所有類型的根。
1. 萬物（數字、字符串、函數、類、模塊等）皆為對象，每個對象均有一個「類型(type)」。對像變量是一個指向變量在內存中位置的指針。
1. 所有對象均會被**引用計數**。

    ```python
    sys.getrefcount(5) => x
    a = 5, b = a
    # 上式會在等號的右邊創建一個對象的引用，因此 a 和 b 均指向 5
    sys.getrefcount(5)
    => x + 2
    del(a); sys.getrefcount(5) => x + 1
    ```

1. 類的基本形式：

    ```python
    class MyObject(object):
        # 'self' 等價於 Java/C++ 中的 'this'
        def __init__(self, name):
            self.name = name
        def memberFunc1(self, arg1):
            pass
        @staticmethod
        def classFunc2(arg1):
            pass
    obj1 = MyObject('name1')
    obj1.memberFunc1('a')
    MyObject.classFunc2('b')
    ```

1. 有用的交互式工具：

    ```python
    dir(variable1)  # 列出對象的所有可用方法
    ```

## 常見字符串操作

```python
# 通過分隔符連接列表/元組
', '.join([ 'v1', 'v2', 'v3']) => 'v1, v2, v3'

# 格式化字符串
string1 = 'My name is {0}　{name}'
newString1 = string1.format('Sean', name =　'Chen')

# 分裂字符串
sep = '-';
stringList1 =　string1.split(sep)

# 獲取子串
start = 1;
string1[start:8]

# 補 '0' 向右對齊字符串
month = '5';
month.zfill(2) => '05'
month = '12';
month.zfill(2) => '12'
month.zfill(3) => '012'
```

## 異常處理

1. 基本形式：

    ```python
    try:
        pass
    except ValueError as e:
        print e
    except (TypeError, AnotherError):
        pass
    except:
        pass
    finally:
        pass  # 清理，比如 close db;
    ```

1. 手動引發異常：

    ```python
    raise AssertionError  # 斷言失敗
    raise SystemExit
    # 請求程序退出
    raise RuntimeError('錯誤信息 :..')
    ```

## 列表、字典以及元組的推導表達式

使代碼更加易讀易寫的語法糖。

1. **列表推導**

    - 用一個簡練的表達式，通過篩選一個數據集並且轉換經過篩選的元素的方式來簡明地生成新列表。
    - 基本形式：

        ```python
        [expr for val in collection if condition]
        ```

    等價於

    ```python
    result = []
    for val in collection:
        if condition:
            result.append(expr)
    ```

    可以省略過濾條件，只留下表達式。

2. **字典推導**

    - 基本形式：

        ```python
        {key-expr : value-expr for value in collection if condition}
        ```

3. **集合推導**

    - 基本形式：和列表推導一樣，不過是用 `()` 而不是 `[]` 。

4. **嵌套列表**

    - 基本形式：

        ```python
        [expr for val in collection for innerVal in val if condition]
        ```

## 單元測試

Python自帶`unittest`模塊，可供我們編寫單元測試。

```python
import unittest
```

我們可以編寫繼承於`unittest.TestCase`測試類的子類，並在子類中編寫具體的測試函數。測試函數命必須以`test_`開頭，否則不會被識別為測試函數，進而不會在運行單元測試時被運行。

```python
class TestSubclass(unittest.TestCase):

    def test_func(self):
        self.assertEqual(0, 0)
        # 可以通過msg關鍵字參數提供測試失敗時的提示消息
        self.assertEqual(0, 0, msg='modified message')
        self.assertGreater(1, 0)
        self.assertIn(0, [0])
        self.assertTrue(True)
        # 測試是否會拋出異常
        with self.assertRaises(KeyError):
            _ = dict()[1]

    # 被@unittest.skip裝飾器裝飾的測試類或測試函數會被跳過
    @unittest.skip(reason='just skip')
    def test_skip(self):
        raise Exception('I shall never be tested')
```

另外，`unittest.TestCase`中還有兩個特殊的成員函數，他們分別會在調用每一個測試函數的前後運行。在測試前連接數據庫並在測試完成後斷開連接是一種常見的使用場景。

```python
def setUp(self):
    # To do: connect to the database
    pass

def tearDown(self):
    # To do: release the connection
    pass

def test_database(self):
    # To do: test the database
    pass
```

測試類編寫完畢後，可以通過添加以下代碼來將當前文件當成正常的Python腳本使用

```python
if __name__ == '__main__':
  unittest.main()
```
