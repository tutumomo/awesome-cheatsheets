JavaScript速查表
===
- 本手冊絕大部分內容是從Airbnb JavaScript Style Guide精簡整理，將開發者們都明確的操作去掉，目的為了就是更快的速查。
  此處為[源地址](https://github.com/airbnb/javascript)。

- 譯制：[HaleNing](https://github.com/HaleNing)



## 目錄
  - [基礎知識](#基礎知識)
    - [類型](#類型)
    - [引用](#引用)
    - [對像](#對像)
    - [數組](#數組)
    - [解構](#解構)
    - [字符串](#字符串)
    - [變量](#變量)
    - [屬性](#屬性)
    - [測試](#測試)
  - [公共約束](#公共約束)
    - [註釋](#註釋)
    - [分號](#分號)
    - [命名規範](#命名規範)
    - [標準庫](#標準庫)
  - [類與函數](#類與函數)
    - [函數](#函數)
    - [箭頭函數](#箭頭函數)
    - [類與構造函數](#類與構造函數)
    - [模塊](#模塊)
    - [迭代器與生成器](#迭代器與生成器)
    - [提升](#提升)
    - [比較運算符與相等](#比較運算符與相等)
    - [事件](#事件)
    - [類型轉換與強制轉換](#類型轉換與強制轉換)
  - [推薦資源](#推薦資源)




## 基礎知識


### 類型

- 基本類型
  **最新的 ECMAScript 標準定義了 8 種數據類型,分別是**
  - `string`
  - `number`
  - `bigint`
  - `boolean`
  - `null`
  - `undefined`
  - `symbol` (ECMAScript 2016新增)
> 所有基本類型的值都是不可改變的。但需要注意的是，基本類型本身和一個賦值為基本類型的變量的區別。變量會被賦予一個新值，而原值不能像數組、對像以及函數那樣被改變。
- 引用類型
  - `Object`（包含普通對像-Object，數組對像-Array，正則對像-RegExp，日期對像-Date，數學函數-Math，函數對像-Function）

```javascript
使用 typeof 運算符檢查：

undefined：typeof instance === "undefined"
Boolean：typeof instance === "boolean"
Number：typeof instance === "number"
String：typeof instance === "string
BigInt：typeof instance === "bigint"
Symbol ：typeof instance === "symbol"
null：typeof instance === "object"。
Object：typeof instance === "object"
```



### 引用

推薦常量賦值都使用`const`, 值可能會發生改變的變量賦值都使用 `let`。

> 為什麼？`let`   `const` 都是塊級作用域，而 `var`是函數級作用域

```javascript

// bad
var count = 1;
if (true) {
  count += 1;
}

// good, use the let and const 
let count = 1;
const pi =3.14;
if (true) {
  count += 1;
}
```



### 對像

- 使用字面語法創建對像：

  ```javascript
  // bad
  const item = new Object();
  
  // good
  const item = {};
  ```

  

- 在創建具有動態屬性名稱的對象時使用屬性名稱:

  ```javascript
  
  function getKey(k) {
    return `a key named ${k}`;
  }
  
  // bad
  const obj = {
    id: 5,
    name: 'San Francisco',
  };
  obj[getKey('enabled')] = true;
  
  // good
  const obj = {
    id: 5,
    name: 'San Francisco',
    [getKey('enabled')]: true,
  };
  ```

  

- 屬性值簡寫，並且推薦將縮寫 寫在前面 :

  ```javascript
  const lukeSkywalker = 'Luke Skywalker';
  //常量名就是你想設置的屬性名
  // bad
  const obj = {
    lukeSkywalker: lukeSkywalker,
  };
  
  // good
  const obj = {
    lukeSkywalker,
  };
  
  const anakinSkywalker = 'Anakin Skywalker';
  const lukeSkywalker = 'Luke Skywalker';
  
  // good
  const obj = {
    lukeSkywalker,
    anakinSkywalker,
    episodeOne: 1,
    twoJediWalkIntoACantina: 2,
    episodeThree: 3,
    mayTheFourth: 4,
  };
  ```

  

- 不要直接調用 `Object.prototype`上的方法，如 `hasOwnProperty`、`propertyIsEnumerable`、`isPrototypeOf`

  > 為什麼？在一些有問題的對象上，這些方法可能會被屏蔽掉，如：`{ hasOwnProperty: false }` 或空對像 `Object.create(null)`

  ```javascript
  // bad
  console.log(object.hasOwnProperty(key));
  
  // good
  console.log(Object.prototype.hasOwnProperty.call(object, key));
  
  // best
  const has = Object.prototype.hasOwnProperty; 
  console.log(has.call(object, key));
  /* or */
  import has from 'has'; // https://www.npmjs.com/package/has
  console.log(has(object, key));
  ```

  

- 對像拷貝時，推薦使用`...`運算符來代替`Object.assign`, 獲取大對象的多個屬性時，也推薦使用`...`運算符

  ```javascript
  // very bad, 因為line2的操作更改了original
  const original = { a: 1, b: 2 };
  const copy = Object.assign(original, { c: 3 }); 
  // 將不需要的屬性刪除了
  delete copy.a; 
  
  // bad
  const original = { a: 1, b: 2 };
  const copy = Object.assign({}, original, { c: 3 }); // copy => { a: 1, b: 2, c: 3 }
  
  // good 使用 es6 擴展運算符 ...
  const original = { a: 1, b: 2 };
  // 淺拷貝
  const copy = { ...original, c: 3 }; // copy => { a: 1, b: 2, c: 3 }
  
  // rest 解構運算符
  const { a, ...noA } = copy; // noA => { b: 2, c: 3 }
  ```

  



### 數組

- 用擴展運算符做數組淺拷貝，類似上面的對象淺拷貝：

  ```javascript
  // bad
  const len = items.length;
  const itemsCopy = [];
  let i;
  
  for (i = 0; i < len; i += 1) {
    itemsCopy[i] = items[i];
  }
  
  // good
  const itemsCopy = [...items];
  ```

- 用 `...` 運算符而不是 [`Array.from`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/from) 來將一個可迭代的對象轉換成數組:

  ```javascript
  const foo = document.querySelectorAll('.foo');
  
  // good
  const nodes = Array.from(foo);
  
  // best
  const nodes = [...foo];
  ```

  

- 使用 [`Array.from`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/from) 而不是 `...` 運算符去做 map 遍歷。 因為這樣可以避免創建一個臨時數組：

  ```javascript
  // bad
  const baz = [...foo].map(bar);
  
  // good
  const baz = Array.from(foo, bar);
  ```

  

- 如果一個數組有很多行，在數組的 `[` 後和 `]` 前斷行 :

  ```javascript
  
  // good
  const arr = [[0, 1], [2, 3], [4, 5]];
  
  const objectInArray = [
    {
      id: 1,
    },
    {
      id: 2,
    },
  ];
  
  const numberInArray = [
    1,
    2,
  ];
  ```

  

### 解構

- 用對象的解構賦值來獲取和使用對像某個或多個屬性值:

  ```javascript
  // bad
  function getFullName(user) {
    const firstName = user.firstName;
    const lastName = user.lastName;
  
    return `${firstName} ${lastName}`;
  }
  
  // good
  function getFullName(user) {
    const { firstName, lastName } = user;
    return `${firstName} ${lastName}`;
  }
  
  // best
  function getFullName({ firstName, lastName }) {
    return `${firstName} ${lastName}`;
  }
  ```

  

- 數組解構:

  ```javascript
  const arr = [1, 2, 3, 4];
  
  // bad
  const first = arr[0];
  const second = arr[1];
  const four = arr[3];
  
  // good
  const [first, second, _,four] = arr;
  ```

  

- 多個返回值用對象的解構，而不是數組解構:

  ```javascript
  // bad
  function processInput(input) {
    return [left, right, top, bottom];
  }
  
  // 數組解構，必須明確前後順序
  const [left, __, top] = processInput(input);
  
  // good
  function processInput(input) {
    return { left, right, top, bottom };
  }
  // 只需要關注值，而不用關注順序
  const { left, top } = processInput(input);
  ```

  



### 字符串

- 當需要動態生成字符串時，使用模板字符串而不是字符串拼接：

  ```javascript
  // bad
  function sayHi(name) {
    return 'How are you, ' + name + '?';
  }
  
  // bad
  function sayHi(name) {
    return ['How are you, ', name, '?'].join();
  }
  
  
  // good 可讀性比上面更強
  function sayHi(name) {
    return `How are you, ${name}?`;
  }
  ```

  

- 永遠不要使用 `eval()`，該方法有太多漏洞。


### 變量

-  不要使用鏈式變量賦值

> 因為會產生隱式的全局變量

```javascript
// bad
(function example() {
  // JavaScript interprets this as
  // let a = ( b = ( c = 1 ) );
  // The let keyword only applies to variable a; variables b and c become
  // global variables.
  let a = b = c = 1;
}());

console.log(a); // throws ReferenceError
// 在塊的外層也訪問到了，代表這是一個全局變量。
console.log(b); // 1 
console.log(c); // 1

// good
(function example() {
  let a = 1;
  let b = a;
  let c = a;
}());

console.log(a); // throws ReferenceError
console.log(b); // throws ReferenceError
console.log(c); // throws ReferenceError

// the same applies for `const`
```



- 不要使用一元自增自減運算符（`++`， `--`）

  > 根據 eslint 文檔，一元增量和減量語句受到自動分號插入的影響，並且可能會導致應用程序中的值遞增或遞減的靜默錯誤。 使用 `num + = 1` 而不是 `num ++` 或 `num ++` 語句也是含義清晰的。

```javascript
  // bad

  const array = [1, 2, 3];
  let num = 1;
  num++;
  --num;

  let sum = 0;
  let truthyCount = 0;
  for (let i = 0; i < array.length; i++) {
    let value = array[i];
    sum += value;
    if (value) {
      truthyCount++;
    }
  }

  // good

  const array = [1, 2, 3];
  let num = 1;
  num += 1;
  num -= 1;

  const sum = array.reduce((a, b) => a + b, 0);
  const truthyCount = array.filter(Boolean).length;

```


### 屬性

- 訪問屬性時使用點符號

```javascript
const luke = {
  jedi: true,
  age: 28,
};

// bad
const isJedi = luke['jedi'];

// good
const isJedi = luke.jedi;
```

- 根據表達式訪問屬性時使用`[]`

```javascript
const luke = {
  jedi: true,
  age: 28,
};

function getProp(prop) {
  return luke[prop];
}

const isJedi = getProp('je'+'di');
```



### 測試

- 無論用哪個測試框架，都需要寫測試。
- 盡量去寫很多小而美的函數，減少突變的發生
- 小心 stub 和 mock —— 這會讓你的測試變得容易出現問題。
- 100% 測試覆蓋率是我們努力的目標，即便實際上很少達到。
- 每當你修了一個 bug， 都要盡量寫一個回歸測試。 如果一個 bug 修復了，沒有回歸測試，很可能以後會再次出問題。




## 公共約束

### 註釋

- 多行註釋用 `/** ... */`

```javascript
// bad
// make() returns a new element
// based on the passed in tag name
//
// @param {String} tag
// @return {Element} element
function make(tag) {

  // ...

  return element;
}

// good
/**
 * make() returns a new element
 * based on the passed-in tag name
 */
function make(tag) {

  // ...

  return element;
}
```

- 單行註釋用 `//`

```javascript
// bad
const active = true;  // is current tab

// good
// is current tab
const active = true;

// bad
function getType() {
  console.log('fetching type...');
  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}

// good
function getType() {
  console.log('fetching type...');

  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}

// also good
function getType() {
  // set the default type to 'no type'
  const type = this._type || 'no type';

  return type;
}
```

- 用 `// FIXME:` 給問題註釋,用 `// TODO:` 去註釋待辦

### 分號

> 為什麼？當 JavaScript 遇到沒有分號結尾的一行，它會執行 [自動插入分號](https://tc39.github.io/ecma262/#sec-automatic-semicolon-insertion) 這一規則來決定行末是否加分號。如果 JavaScript 在你的斷行裡錯誤的插入了分號，就會出現一些古怪的行為。顯式配置代碼檢查去檢查沒有帶分號的地方可以幫助你防止這種錯誤。

```javascript
// bad - raises exception
const luke = {}
const leia = {}
[luke, leia].forEach((jedi) => jedi.father = 'vader')

// bad - raises exception
const reaction = "No! That』s impossible!"
(async function meanwhileOnTheFalcon() {
  // handle `leia`, `lando`, `chewie`, `r2`, `c3p0`
  // ...
}())

// bad - returns `undefined` instead of the value on the next line - always happens when `return` is on a line by itself because of ASI!
function foo() {
  return
    'search your feelings, you know it to be foo'
}

// good
const luke = {};
const leia = {};
[luke, leia].forEach((jedi) => {
  jedi.father = 'vader';
});

// good
const reaction = "No! That』s impossible!";
(async function meanwhileOnTheFalcon() {
  // handle `leia`, `lando`, `chewie`, `r2`, `c3p0`
  // ...
}());

// good
function foo() {
  return 'search your feelings, you know it to be foo';
}
```


### 命名規範

- `export default` 導出模塊A，則這個文件名也叫 `A.*`， `import` 時候的參數也叫 `A` :

```javascript
// file 1 contents
class CheckBox {
  // ...
}
export default CheckBox;

// file 2 contents
export default function fortyTwo() { return 42; }

// file 3 contents
export default function insideDirectory() {}

// in some other file
// bad
import CheckBox from './checkBox'; // PascalCase import/export, camelCase filename
import FortyTwo from './FortyTwo'; // PascalCase import/filename, camelCase export
import InsideDirectory from './InsideDirectory'; // PascalCase import/filename, camelCase export

// bad
import CheckBox from './check_box'; // PascalCase import/export, snake_case filename
import forty_two from './forty_two'; // snake_case import/filename, camelCase export
import inside_directory from './inside_directory'; // snake_case import, camelCase export
import index from './inside_directory/index'; // requiring the index file explicitly
import insideDirectory from './insideDirectory/index'; // requiring the index file explicitly

// good
import CheckBox from './CheckBox'; // PascalCase export/import/filename
import fortyTwo from './fortyTwo'; // camelCase export/import/filename
import insideDirectory from './insideDirectory'; // camelCase export/import/directory name/implicit "index"
// ^ supports both insideDirectory.js and insideDirectory/index.js
```

- 當你`export default`一個函數時，函數名用小駝峰，文件名和函數名一致, export 一個結構體/類/單例/函數庫/對像 時用大駝峰。

```javascript
function makeStyleGuide() {
  // ...
}

export default makeStyleGuide;



const AirbnbStyleGuide = {
  es6: {
  }
};

export default AirbnbStyleGuide;
```


### 標準庫

> [標準庫](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects)中包含一些由於歷史原因遺留的工具類

- 用 `Number.isNaN` 代替全局的 `isNaN`:

  ```javascript
  // bad
  isNaN('1.2'); // false
  isNaN('1.2.3'); // true
  
  // good
  Number.isNaN('1.2.3'); // false
  Number.isNaN(Number('1.2.3')); // true
  ```

- 用 `Number.isFinite` 代替 `isFinite`

```javascript
// bad
isFinite('2e3'); // true

// good
Number.isFinite('2e3'); // false
Number.isFinite(parseInt('2e3', 10)); // true
```


## 類與函數

### 函數

- 使用命名函數表達式而不是函數聲明

  > 為什麼？這是因為函數聲明會發生提升，這意味著在一個文件裡函數很容易在其被定義之前就被引用了。這樣傷害了代碼可讀性和可維護性。如果你發現一個函數又大又複雜，且這個函數妨礙了這個文件其他部分的理解性，你應當單獨把這個函數提取成一個單獨的模塊。不管這個名字是不是由一個確定的變量推斷出來的，別忘了給表達式清晰的命名（這在現代瀏覽器和類似 babel 編譯器中很常見）。這消除了由匿名函數在錯誤調用棧產生的所有假設。 ([討論](https://github.com/airbnb/javascript/issues/794))

  ```javascript
  // bad
  function foo() {
    // ...
  }
  
  // bad
  const foo = function () {
    // ...
  };
  
  // good
  // lexical name distinguished from the variable-referenced invocation(s)
  // 函數表達式名和聲明的函數名是不一樣的
  const short = function longUniqueMoreDescriptiveLexicalFoo() {
    // ...
  };
  ```

  

- 把立即執行函數包裹在圓括號裡:

  > 立即執行函數：Immediately Invoked Function expression = IIFE。 為什麼？因為這樣使代碼讀起來更清晰（譯者註：我咋不覺得）。 另外，在模塊化世界裡，你幾乎用不著 IIFE。

  ```javascript
  // immediately-invoked function expression (IIFE)
  ( ()=> {
    console.log('Welcome to the Internet. Please follow me.');
  }() );
  ```

- 不要用 `arguments` 命名參數。他的優先級高於每個函數作用域自帶的 `arguments` 對象，這會導致函數自帶的 `arguments` 值被覆蓋:

  ```javascript
  // bad
  function foo(name, options, arguments) {
    // ...
  }
  
  // good
  function foo(name, options, args) {
    // ...
  }
  ```

- 用默認參數語法而不是在函數里對參數重新賦值

  ```javascript
  // really bad
  function handleThings(opts) {
    // 如果 opts 的值為 false, 它會被賦值為 {}
    // 雖然你想這麼寫，但是這個會帶來一些微妙的 bug。
    opts = opts || {};
    // ...
  }
  
  // still bad
  function handleThings(opts) {
    if (opts === void 0) {
      opts = {};
    }
    // ...
  }
  
  // good
  function handleThings(opts = {}) {
    // ...
  }
  ```

- 把默認參數賦值放在最後面

  ```javascript
  // bad
  function handleThings(opts = {}, name) {
    // ...
  }
  
  // good
  function handleThings(name, opts = {}) {
    // ...
  }
  ```

- 不要修改參數，也不要重新對函數參數賦值：

  > 容易導致bug，另外重新對參數賦值也會導致優化問題。

  ```javascript
  // bad
  function f1(a) {
    a = 1;
    // ...
  }
  
  function f2(a) {
    if (!a) { a = 1; }
    // ...
  }
  
  // good
  function f3(a) {
    const b = a || 1;
    // ...
  }
  
  function f4(a = 1) {
    // ...
  }
  ```

  



### 箭頭函數

- 當需要使用箭頭函數的時候，使用它，但是不要濫用

  > 當函數邏輯複雜時，不推薦使用箭頭函數，而是單獨抽出來放在一個函數里。

  ```javascript
  // bad
  [1, 2, 3].map(function (x) {
    const y = x + 1;
    return x * y;
  });
  
  // good
  [1, 2, 3].map((x) => {
    const y = x + 1;
    return x * y;
  });
  ```

- 避免箭頭函數與比較操作符混淆

  ```javascript
  // bad
  const itemHeight = (item) => item.height <= 256 ? item.largeSize : item.smallSize;
  
  // bad
  const itemHeight = (item) => item.height >= 256 ? item.largeSize : item.smallSize;
  
  // good
  const itemHeight = (item) => (item.height <= 256 ? item.largeSize : item.smallSize);
  
  // good
  const itemHeight = (item) => {
    const { height, largeSize, smallSize } = item;
    return height <= 256 ? largeSize : smallSize;
  };
  ```

  

### 類與構造函數

- 使用`class` 語法。避免直接操作 `prototype`

  ```javascript
  // bad
  function Queue(contents = []) {
    this.queue = [...contents];
  }
  Queue.prototype.pop = function () {
    const value = this.queue[0];
    this.queue.splice(0, 1);
    return value;
  };
  
  // good
  class Queue {
    constructor(contents = []) {
      this.queue = [...contents];
    }
    pop() {
      const value = this.queue[0];
      this.queue.splice(0, 1);
      return value;
    }
  }

- 用 `extends` 實現繼承:

  > 為什麼？它是一種內置的方法來繼承原型功能而不破壞 `instanceof`

  ```javascript
  // bad
  const inherits = require('inherits');
  function PeekableQueue(contents) {
    Queue.apply(this, contents);
  }
  inherits(PeekableQueue, Queue);
  PeekableQueue.prototype.peek = function () {
    return this.queue[0];
  }
  
  // good
  class PeekableQueue extends Queue {
    peek() {
      return this.queue[0];
    }
  }
  ```

  

- 方法可以返回 `this` 來實現鏈式調用

```javascript
// bad
Jedi.prototype.jump = function () {
  this.jumping = true;
  return true;
};

Jedi.prototype.setHeight = function (height) {
  this.height = height;
};

const luke = new Jedi();
luke.jump(); // => true
luke.setHeight(20); // => undefined

// good
class Jedi {
  jump() {
    this.jumping = true;
    return this;
  }

  setHeight(height) {
    this.height = height;
    return this;
  }
}

const luke = new Jedi();

luke.jump()
  .setHeight(20);
```



- 自定義 `toString()` 方法是可以的，但需要保證它可以正常工作

```javascript
class Jedi {
  constructor(options = {}) {
    this.name = options.name || 'no name';
  }

  getName() {
    return this.name;
  }

  toString() {
    return `Jedi - ${this.getName()}`;
  }
}
```

- 如果沒有特別定義，類有默認的構造方法。一個空的構造函數或只是代表父類的構造函數是不需要寫的。

```javascript
// bad
class Jedi {
  constructor() {}

  getName() {
    return this.name;
  }
}

// bad
class Rey extends Jedi {
  // 這種構造函數是不需要寫的
  constructor(...args) {
    super(...args);
  }
}

// good
class Rey extends Jedi {
  constructor(...args) {
    super(...args);
    this.name = 'Rey';
  }
}
```



### 模塊

- 使用（`import`/`export`）模塊

```javascript
// bad
const AirbnbStyleGuide = require('./AirbnbStyleGuide');
module.exports = AirbnbStyleGuide.es6;

// ok
import AirbnbStyleGuide from './AirbnbStyleGuide';
export default AirbnbStyleGuide.es6;

// best
import { es6 } from './AirbnbStyleGuide';
export default es6;
```

- 不要導出可變的東西:

> 變化通常都是需要避免，特別是當你要輸出可變的綁定。雖然在某些場景下可能需要這種技術，但總的來說應該導出常量。

```javascript
// bad
let foo = 3;
export { foo }

// good
const foo = 3;
export { foo }
```

- import JavaScript文件不用包含擴展名

```javascript
// bad
import foo from './foo.js';
import bar from './bar.jsx';
import baz from './baz/index.jsx';

// good
import foo from './foo';
import bar from './bar';
import baz from './baz';
```



### 迭代器與生成器

- 不要用迭代器。使用 JavaScript 高級函數代替 `for-in`、 `for-of`

  > 用數組的這些迭代方法： `map()` / `every()` / `filter()` / `find()` / `findIndex()` / `reduce()` / `some()` / ... , 對象的這些方法 `Object.keys()` / `Object.values()` / `Object.entries()` 得到一個數組，就能去遍歷對象。

  ```javascript
  const numbers = [1, 2, 3, 4, 5];
  
  // bad
  let sum = 0;
  for (let num of numbers) {
    sum += num;
  }
  sum === 15;
  
  // good
  let sum = 0;
  numbers.forEach((num) => sum += num);
  sum === 15;
  
  // best (use the functional force)
  const sum = numbers.reduce((total, num) => total + num, 0);
  sum === 15;
  
  // bad
  const increasedByOne = [];
  for (let i = 0; i < numbers.length; i++) {
    increasedByOne.push(numbers[i] + 1);
  }
  
      // good
  const increasedByOne = [];
  numbers.forEach((num) => {
    increasedByOne.push(num + 1);
  });
  
  // best (keeping it functional)
  const increasedByOne = numbers.map((num) => num + 1);
  ```


### 提升

- `var` 聲明會被提前到離他最近的作用域的最前面，但是它的賦值語句並沒有提前。`const` 和 `let` 被賦予了新的概念 [暫時性死區 (TDZ)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/let#temporal_dead_zone_tdz)。 重要的是要知道為什麼 [typeof 不再安全](https://web.archive.org/web/20200121061528/http://es-discourse.com/t/why-typeof-is-no-longer-safe/15)。

```javascript
// 我們知道這個不會工作，假設沒有定義全局的 notDefined
function example() {
  console.log(notDefined); // => throws a ReferenceError
}

// 在你引用的地方之後聲明一個變量，他會正常輸出是因為變量提升。
// 注意： declaredButNotAssigned 的值 true 沒有被提升。
function example() {
  console.log(declaredButNotAssigned); // => undefined
  var declaredButNotAssigned = true;
}

// 可以寫成如下例子， 二者意義相同。
function example() {
  let declaredButNotAssigned;
  console.log(declaredButNotAssigned); // => undefined
  declaredButNotAssigned = true;
}

// 用 const，let就不一樣了。
function example() {
  console.log(declaredButNotAssigned); // => throws a ReferenceError
  console.log(typeof declaredButNotAssigned); // => throws a ReferenceError
  const declaredButNotAssigned = true;
}
```

- 已命名函數表達式提升他的變量名，不是函數名或函數體

```javascript
function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  superPower(); // => ReferenceError superPower is not defined

  var named = function superPower() {
    console.log('Flying');
  };
}

// 函數名和變量名一樣是也如此。
function example() {
  console.log(named); // => undefined

  named(); // => TypeError named is not a function

  var named = function named() {
    console.log('named');
  };
}
```

### 比較運算符與相等

- 用 `===` 和 `!==` 嚴格比較而不是 `==` 和 `!=`

- 條件語句，例如if語句使用coercion與tobooleant抽像方法評估它們的表達式，始終遵循這些簡單的規則：
  - **Objects** evaluate to **true**
  - **Undefined** evaluates to **false**
  - **Null** evaluates to **false**
  - **Booleans** evaluate to **the value of the boolean**
  - **Numbers** evaluate to **false** if **+0, -0, or NaN**, otherwise **true**
  - **Strings** evaluate to **false** if an empty string `''`, otherwise **true**

```javascript
if ([0] && []) {
  // true
  // an array (even an empty one) is an object, objects will evaluate to true
}
```

- 三元表達式不應該嵌套，盡量保持單行表達式

```javascript
// bad
const foo = maybe1 > maybe2
  ? "bar"
  : value1 > value2 ? "baz" : null;

// better
const maybeNull = value1 > value2 ? 'baz' : null;

const foo = maybe1 > maybe2
? 'bar'
  : maybeNull;

// best
const maybeNull = value1 > value2 ? 'baz' : null;

const foo = maybe1 > maybe2 ? 'bar' : maybeNull;
```

### 事件

- 當把數據載荷傳遞給事件時（例如是 DOM 還是像 Backbone 這樣有很多屬性的事件）。這使得後續的貢獻者（程序員）向這個事件添加更多的數據時不用去找或者更新每個處理器。

```javascript
// bad
$(this).trigger('listingUpdated', listing.id);

// ...

$(this).on('listingUpdated', (e, listingID) => {
  // do something with listingID
});
```


### 類型轉換與強制轉換

- 字符串

```javascript
// => this.reviewScore = 9;

// bad
const totalScore = new String(this.reviewScore); // typeof totalScore is "object" not "string"

// bad
const totalScore = this.reviewScore + ''; 

// bad
const totalScore = this.reviewScore.toString(); // 不保證返回 string

// good
const totalScore = String(this.reviewScore);
```

- 數字: 用 `Number` 做類型轉換，`parseInt` 轉換 `string` 應總是帶上進制位

```javascript
const inputValue = '4';

// bad
const val = new Number(inputValue);

// bad
const val = +inputValue;

// bad
const val = inputValue >> 0;

// bad
const val = parseInt(inputValue);

// good
const val = Number(inputValue);

// good
const val = parseInt(inputValue, 10);
```

- 移位運算要小心

  > 移位運算對大於 32 位的整數會導致意外行為。[Discussion](https://github.com/airbnb/javascript/issues/109). 最大的 32 位整數是 2,147,483,647:

```javascript
2147483647 >> 0 //=> 2147483647
2147483648 >> 0 //=> -2147483648
2147483649 >> 0 //=> -2147483647
```

## 推薦資源
- 網站：
  - [MDN](https://developer.mozilla.org/zh-CN/docs/Web/): 不管你是僅僅開始入門、學過一點基礎或者是個網站開發老手，你都能在這裡找到有用的資源。
  - [JS週刊](https://javascriptweekly.com/) : 你可以在這裡，接收到JS社區裡最新的動態，其他開發者編寫的優秀工具，閱讀優秀的文章。
  - [印記中文](https://docschina.org/) : JS及其前端領域的文檔集合。

- 書籍(為了尊重作者的版權，下列書籍僅開源書籍提供鏈接)：
  - JavaScript權威指南（原書第7版）
  - [你不知道的JS](https://github.com/getify/You-Dont-Know-JS)
  - [Eloquent JavaScript](https://eloquentjavascript.net/)
