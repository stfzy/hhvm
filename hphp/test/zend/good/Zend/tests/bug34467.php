<?hh
class abc {
    private $arr;

    function __set ($key, $value) {
        if ($this->arr === null) $this->arr = array();
        $this->arr[$key] = $value;
    }

    function __get ($key) {
      return $this->arr[$key];
    }
}
<<__EntryPoint>> function main(): void {
$abc = new abc();
foreach (array (1,2,3) as $abc->k => $abc->v) {
    var_dump($abc->k,$abc->v);
}
}
