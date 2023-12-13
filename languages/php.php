<?php

/**
 * Class 
 * http://php.net/manual/zh/language.oop5.basic.php
 */
class NormalClass extends AbstractClassName implements InterfaceName
{
    // 引用 Trait (為 PHP 提供多繼承的能力，可理解為代碼複製)
    use TraitName;

    // --> 類屬性類型 <--

    /**
     * 公有的類成員可以在任何地方被訪問，會被繼承。
     * @var Type
     */
    public $property;

    /**
     * 私有的類成員則只能被其定義所在的類訪問，不會被繼承。
     * @var Type
     */
    private $property;

    /**
     * 受保護的類成員則可以被其自身以及其子類和父類訪問，會被繼承。
     * @var Type
     */
    protected $property;

    /**
     * 靜態變量，也被稱為類變量，所有對象的變量都是同一個。
     * @var Type
     */
    static $property;

    // --> 方法類型 <--

    /**
     * 公共方法，任何對象都能訪問。
     * @param Type
     * @return Type
     */
    public function publicFunction(Type $var = null): Type
    {
    }

    /**
     * 私有方法，只有對象自身可以訪問。
     * @param Type
     * @return Type
     */
    private function privateFunction(Type $var = null): Type
    {
    }

    /**
     * 保護方法，只有自身和子類可以訪問。
     * @param Type
     * @return Type
     */
    protected function protectedFunction(Type $var = null): Type
    {
    }
    
    /**
     * 靜態方法，可以在不實例化類的情況下執行。
     * @param Type
     * @return Type
     */
    public static function staticFunction(Type $var = null): Type
    {
    }

    // --> 魔術方法 <--

    /**
     * 具有構造函數的類會在每次創建新對像時先調用此方法，所以非常適合在使用對像之前做一些初始化工作。
     * http://php.net/manual/zh/language.oop5.decon.php
     * @param Type
     * @return void
     */
    public function __construct(Type $var = null)
    {
    }

    /**
     * 析構函數會在到某個對象的所有引用都被刪除或者當對像被顯式銷毀時執行。
     * http://php.net/manual/zh/language.oop5.decon.php
     * @return void
     */
    public function __destruct()
    {
    }

    /**
     * 在給不可訪問屬性賦值時，__set() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param mixed value
     * @return void
     */
    public function __set(string $name , mixed $value)
    {
    }

    /**
     * 讀取不可訪問屬性的值時，__get() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return mixed
     */
    public function __get(string $name)
    {
    }

    /**
     * 當對不可訪問屬性調用 isset() 或 empty() 時，__isset() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return bool
     */
    public function __isset(string $name)
    {
    }

    /**
     * 當對不可訪問屬性調用 unset() 時，__unset() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @return void
     */
    public function __unset(string $name)
    {
    }

    /**
     * 在對像中調用一個不可訪問方法時，__call() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param array arguments
     * @return mixed
     */
    public function __call(string $name, array $arguments)
    {
    }

    /**
     * 在靜態上下文中調用一個不可訪問方法時，__callStatic() 會被調用。
     * http://php.net/manual/zh/language.oop5.overloading.php
     * @param string name
     * @param array arguments
     * @return mixed
     */
    public static function __callStatic(string $name, array $arguments)
    {
    }

    /**
     * serialize() 函數會檢查類中是否存在一個魔術方法 __sleep()。
     * 如果存在，該方法會先被調用，然後才執行序列化操作。此功能可以用於清理對象，
     * 並返回一個包含對像中所有應被序列化的變量名稱的數組。
     * 如果該方法未返回任何內容，則 NULL 被序列化，並產生一個 E_NOTICE 級別的錯誤。
     * http://php.net/manual/zh/language.oop5.magic.php#object.sleep
     * @return array
     */
    public function __sleep()
    {
    }

    /**
     * 與之相反，unserialize() 會檢查是否存在一個 __wakeup() 方法。
     * 如果存在，則會先調用 __wakeup 方法，預先準備對像需要的資源。
     * http://php.net/manual/zh/language.oop5.magic.php#object.wakeup
     * @return void
     */
    public function __wakeup()
    {
    }

    /**
     * __toString() 方法用於一個類被當成字符串時應怎樣回應。
     * 例如 echo $obj; 應該顯示些什麼。此方法必須返回一個字符串，
     * 否則將發出一條 E_RECOVERABLE_ERROR 級別的致命錯誤。
     * http://php.net/manual/zh/language.oop5.magic.php#object.tostring
     * @return string
     */
    public function __toString()
    {
    }

    /**
     * 當嘗試以調用函數的方式調用一個對像時，__invoke() 方法會被自動調用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.invoke
     * @param Type
     * @return mixed
     */
    public function __invoke(Type $var = null)
    {
    }

    /**
     * 自 PHP 5.1.0 起當調用 var_export() 導出類時，此靜態 方法會被調用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.set-state
     * @param array properties
     * @return object
     */
    public static function __set_state(array $properties)
    {
    }

    /**
     * 在使用 var_dump() 時，會被調用。
     * http://php.net/manual/zh/language.oop5.magic.php#object.debuginfo
     * @return array
     */
    public function __debugInfo()
    {
    }

}

/**
 * 接口
 * 任何實現接口的類，都必須實現接口中的方法。
 */
interface InterfaceName
{

    public function FunctionName(Type $var = null): Type;

}

/**
 * 抽像類
 * 抽像類中可以包含普通方法，和抽像方法。
 */
abstract class AbstractClassName
{

    /**
     * 繼承本抽像類的類，必須實現抽像方法。
     * @param Type
     * @return Type
     */
    abstract function abstractFunction(Type $var = null): Type;

}

/**
 * Trait
 * 提供代碼復用能力、多繼承能力
 */
trait Logger
{
	public function log($message)
	{
		return $message;
	}
}

class WriteLog
{
    use Logger;
    
    public function main()
    {
        return $this->log();
    }
}

