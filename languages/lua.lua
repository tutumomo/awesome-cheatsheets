 --------------------------------------------------------------------------------
 -- Lua CHEATSHEET (中文速查表)  -  by weizhixiangcoder (created on 2020/06/20)
 -- Version: 1
 -- https://github.com/skywind3000/awesome-cheatsheets
 --------------------------------------------------------------------------------
 

---------------------------------------------------------------------------------
--[[
	Lua 特性：
		輕量級：源碼2.5萬行左右C代碼， 方便嵌入進宿主語言(C/C++)
		可擴展：提供了易於使用的擴展接口和機制， 使用宿主語言提供的功能
		高效性：運行最快的腳本語言之一
		可移植：跨平台
	入門書籍《lua程序設計》
		推薦：雲風翻譯的《Lua 5.3參考手冊》	
		http://cloudwu.github.io/lua53doc/manual.html
	源碼： 
		http://www.lua.org/ftp/
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	變量: 作為動態類型語言，變量本身沒有類型， 賦值決定某一時刻變量的類型。私有靜態
	變量帶local, 公有靜態變量不帶local。
		數據類型：
			nil            	為空，無效值，在條件判斷中表示false
			boolean			包含兩個值：false和true
			number			表示雙精度類型的實浮點數
			string			字符串由一對雙引號或單引號來表示
			function		由 C 或 Lua 編寫的函數
			table			Lua 中的表（table）其實是一個"關聯數組"（associative
							arrays），數組的索引可以是數字、字符串或表類型
			thread			協程
			userdata		存儲在變量中的C數據結構
--]]
---------------------------------------------------------------------------------
print(type(signal))						--nil

signal = true				
print(type(signal))						--boolean

signal = 1454
print(type(signal))						--number

signal = "UnionTech"
print(type(signal))						--string			

signal = function() 
	print(type(signal))
end 	
print(type(signal))						--function

signal = {}								
print(type(signal))						--table

signal = coroutine.create(function()
	print(type(signal))
end)
print(type(signal))						--coroutine



---------------------------------------------------------------------------------
--[[
	流程控制：if...elseif...else、 while、 for
--]]
---------------------------------------------------------------------------------
--if...else
ty_signal = type(signal)
if ty_signal == "coroutine" then
    print("signal type is coroutine")
elseif ty_signal == "table" then
    print("signal type is table")
else
    print("signal type is other")
end

--while
ut_companys = {"beijing company", "shanghai company", "nanjing company", "wuxi company", "guangzhou company", "yunfu company", "wuhan company", "chengdu company", "xian company"}
count = 0
while count <= #ut_companys 
do
    count = count + 1
    print("ut_companys[", count, "] is ", ut_companys[count])
end

--for
for i=#ut_companys, 1, -2 do        --以2為步長反向遍歷
    print("num: ", i, "company: ", ut_companys[i])
end


---------------------------------------------------------------------------------
--[[
	table： 表作為Lua唯一自帶的數據結構， 使用簡單方便， 兼具數組和Map作為容器的
	功能，通過表可以很容易組成常見的數據結構， 如棧、隊列、鏈表、集合，用for循環
	很容易迭代遍歷表數據。
--]]
---------------------------------------------------------------------------------
--table當數組用，下標從1開始
for i, c in ipairs(ut_companys) do
	print(string.format("1 UnionTech company: %d		%s", i, c))
end

table.sort(ut_companys)
for i=#ut_companys, 1, -1 do
	print(string.format("2 UnionTech company: %d		%s", i, ut_companys[i]))
end

--table當hash map用
ut_cptypes = {}

ut_cptypes["adapter"] = {"beijing company", "wuhan company", "guangzhou company"}
ut_cptypes["developer"] = {"beijing company", "wuhan company", "nanjing company", "chengdu company", "xian company", "guangzhou company"}
ut_cptypes["general"] = {"beijing company"}

for ty, cps in pairs(ut_cptypes) do
	for i, cp in ipairs(cps) do
		print(string.format("3 UnionTech companys: type:%s  identifier:%s	company:%s", ty, i, cp))
	end
end


---------------------------------------------------------------------------------
--[[
	函數：在Lua中函數也是第一類型值， 可賦值給變量， 也可以在函數體內定義並使用函數，或者
	是直接使用匿名匿名函數。
--]]
---------------------------------------------------------------------------------
--多重返回值
ut_types = {"adapter", "developer", "general"}
function company_types(cp, cptypes)
	local adpt, dvlp, genl = nil, nil, nil
	for i, ty in ipairs(ut_types) do
		for _, _cp in ipairs(cptypes[ty]) do
			if _cp == cp then
				if i == 1 then
					adpt = true
				elseif i == 2 then
					dvlp = true
				elseif i == 3 then
					genl = true
				end
				break
			end
		end
	end
	return adpt, dvlp, genl
end

cp = "wuhan company"
types = {company_types(cp, ut_cptypes)}

for i, ty in ipairs(types) do
	if ty then
		print(string.format("%s  is %s", cp, ut_types[i]))
	end
end 

--變參
function printf(str, ...)
	print(string.format(str, ...))
end

function add_companys(...)
	local newcps = {...}
	local num = #newcps
	for _, cp in ipairs(newcps) do
		table.insert(ut_companys, cp)
	end
	return ut_companys, num
end

_, _ = add_companys("changsha company", "zhengzhou company", "hefei company")
for i=1, #ut_companys do
	--print(string.format("4 UnionTech company: %d		%s", i, ut_companys[i]))
	printf("4 UnionTech company: %d		%s", i, ut_companys[i])
end

--閉包
function all_companys(cps)
	local companys, n = {}, 0
	for _, v in ipairs(cps) do
		table.insert(companys, v)
	end
	return function()
		n = n + 1
		if n > #companys then
			return ""
		else
			return companys[n]
		end
	end
end

get_company = all_companys(ut_companys)
while true
do
	cp = get_company()
	if cp == "" then
		break
	else	
		printf("get company: %s", cp)
	end
end


---------------------------------------------------------------------------------
--[[
	協程(coroutine)：Lua協同程序(coroutine)與線程比較類似：擁有獨立的堆棧，獨立的局
	部變量，獨立的指令指針，同時又與其它協同程序共享全局變量和其它大部分東西。
--]]
---------------------------------------------------------------------------------
function foo (a)
    print("foo 函數輸出", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end
 
co = coroutine.create(function (a , b)
    print("第一次協同程序執行輸出", a, b) -- co-body 1 10
    local r = foo(a + 1)
     
    print("第二次協同程序執行輸出", r)
    local r, s = coroutine.yield(a + b, a - b)  -- a，b的值為第一次調用協同程序時傳入
     
    print("第三次協同程序執行輸出", r, s)
    return b, "結束協同程序"                   -- b的值為第二次調用協同程序時傳入
end)
       
print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
--resume將主協程數據傳入次協程， yield將次協程中數據傳回主協程


---------------------------------------------------------------------------------
--[[
	元表(Metatable)：本質上來說就是存放元方法的表結構， 通過元表實現對表中數據和行為
	的改變。
	Lua 查找一個表元素時的規則，其實就是如下 3 個步驟:
		1.在表中查找，如果找到，返回該元素，找不到則繼續
		2.判斷該表是否有元表，如果沒有元表，返回 nil，有元表則繼續。
		3.判斷元表有沒有 __index 方法，如果 __index 方法為 nil，則返回 nil；如果
		__index 方法是一個表，則重複 1、2、3；如果 __index 方法是一個函數，則返
		回該函數的返回值
	
--]]
---------------------------------------------------------------------------------
father = {
	colourofskin = "yellow",
	weight = 70,
	work = "programming",
	otherwork = function() 
		print "do housework"
	end
}
father.__index = father

son = {
	weight = 50,
	like = "basketball"
}

setmetatable(son, father)
printf("weight:%d 	like:%s  	work:%s		colourofskin:%s ", son.weight, son.like, son.work, son.colourofskin)
son.otherwork()


---------------------------------------------------------------------------------
--[[
    面向對像：因為lua本身不是面向對象的語言， 在lua中， 通過table和function來模擬一個對象， 
    用metatable來模擬面向對像中的繼承，但是在使用的時候需要考慮lua作為腳本語言， 變量的類型隨
    所賦值類型而改變。
--]]
---------------------------------------------------------------------------------
--父類
rect = {
    area = 0,
    length = 0, 
    width = 0,
}

function rect:getArea()
    if self.area == 0 then
        self.area = self.length * self.width
    end
    
    return self.area
end

function rect:getLength()
    return self.length
end

function rect:new(leng, wid)
    self.length = leng
    self.width = wid
    return self    
end

--子類
cuboid = {
    volume = 0,
    height = 0,
}

function cuboid:getVolume()
    if self.volume == 0 then
        self.volume = self.height * self:getArea()
    end
    return self.volume
end

function cuboid:new(_rect, _height)
    setmetatable(self, _rect)
    _rect.__index = _rect
    self.height = _height
    return self
end

rect1 = rect:new(5, 10)
print("rect1 rectangle:", rect1:getArea())

cuboid1 = cuboid:new(rect1, 2)
print("cuboid1 volume: ", cuboid1:getVolume())
print("cuboid1 rectangle: ", cuboid1:getArea())             --子類調用父類方法getArea
print("cuboid1 length function: ", cuboid1:getLength())     --子類調用父類方法getLength
print("cuboid1 length variable: ", cuboid1.length)          --子類使用父類變量length

--重寫子類接口getArea， lua中沒有重載
function cuboid:getArea()                                   
    return 2 * (self.height * self.length + self.height * self.width + self.length * self.width)
end

cuboid2 = cuboid:new(rect1, 2)
print("cuboid2 function: getArea: ", cuboid2:getArea())                     --調用子類重寫的方法getArea
print("cuboid2 base function: getArea: ", getmetatable(cuboid2):getArea())  --顯示調用父類方法getArea


---------------------------------------------------------------------------------
--[[
	模塊與C包: 模塊類似封裝庫， 有利於代碼復用， 降低耦合， 提供被調用的API。
	----------------------------------------------------------------------
	-- 文件名為 module.lua, 定義一個名為 module 的模塊
	module = {}
	module.constant = "這是一個常量"
	function module.func1()
		io.write("這是一個公有函數！\n")
	end
	
	local function func2()
		print("這是一個私有函數！")
	end
	
	function module.func3()
		func2()
	end
 
	return module
	
	在其他模塊中調用module模塊：
	local m = require("module")
	print(m.constant)
	----------------------------------------------------------------------
	與Lua中寫包不同，C包在使用以前必須首先加載並連接，在大多數系統中最容易的實現方式
	是通過動態連接庫機制。Lua在一個叫loadlib的函數內提供了所有的動態連接的功能。
	
	----------------------------------------------------------------------
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	lua標準庫： 標準庫中接口可直接使用不需要require
	常用標準庫：
		math		數學計算
		table		表結構數據處理
		string		字符串處理
		os			系統庫函數
		io			文件讀寫
		coroutine	協程庫
		debug		調式器
--]]
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
--[[
	lua虛擬機：腳本語言沒有像編譯型語言那樣直接編譯為機器能識別的機器代碼，這意味著
	解釋性腳本語言與編譯型語言的區別：由於每個腳本語言都有自己的一套字節碼，與具體的
	硬件平台無關，所以無需修改腳本代碼，就能運行在各個平台上。硬件、軟件平台的差異都
	由語言自身的虛擬機解決。由於腳本語言的字節碼需要由虛擬機執行，而不像機器代碼那樣
	能夠直接執行，所以運行速度比編譯型語言差不少。有了虛擬機這個中間層，同樣的代碼可
	以不經修改就運行在不同的操作系統、硬件平台上。Java、Python都是基於虛擬機的編程語
	言，Lua同樣也是這樣。


--]]
---------------------------------------------------------------------------------




--可在命令行lua lua.lua運行本腳本
