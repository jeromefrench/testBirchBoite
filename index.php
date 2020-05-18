<?php
/* Author : Jerome CHARDIN */
/* mail : jerome.chardin@live.fr */
/* test BirchBox */



if (!isset($_SESSION)) {
    session_start();
}

Class User {
	public $name;
	public $age;

	function __construct($kwargs) {
		$this->name = $kwargs['name'];
		$this->age = $kwargs['age'];
	}

	public static function validation($kwargs){
		if (!array_key_exists('name', $kwargs))
			return "Field name empty";
		if (!array_key_exists('age', $kwargs))
			return "Field age empty";
		if ($kwargs['name'] == "")
			return "Field name empty";
		if (!is_numeric($kwargs['age']))
			return "Field age should be a number";
		return true;
	}

	public function addToList(){
		if (array_key_exists('userList', $_SESSION)){
			$lastKey = count($_SESSION['userList']) + 1;
			$_SESSION['userList'][$lastKey + 1] = $this;
		}
		else{
			$_SESSION['userList'][0] = $this;
		}
	}

	public static function displayList(){
		if ($_SESSION['userList']){
			echo "<h2>User list</h2>";
			foreach ($_SESSION['userList'] as $key => $oneUser){
				echo <<<HTML
			<ul>
				<li> {$oneUser->name}</li>
				<li> {$oneUser->age} </li>
			</ul>
HTML;
			}
		}
	}
}

$userValid = false;
$clickAddUser = false;

if($_POST != null && $_POST['submit'] != null && $_POST['submit'] == "Add user")
	$clickAddUser = true;

if($clickAddUser)
	$userValid = User::validation($_POST);

if ($userValid === true){
	$user = new User($_POST);
	$user->addToList();
}

echo <<<HTML
<html>
	<head>
		<meta charset="utf-8" />
		<title>Birchbox Test</title>
	</head>
	<body>
	<h2>Formulaire</h2>
	<form action="index.php" method="post">
		<label for="name">Enter user name:</label></br>
		<input type="text" name="name" id="name"  placeholder="Name" ></br>
		</br>

		<label for="age">Enter user age:</label></br>
		<input type="number" name="age" id="age"  placeholder="Age" ></br>
		</br>
		<input type="submit" name="submit" value="Add user" >
	</form>
HTML;

if($clickAddUser && $userValid === true)
	echo "User added !";
elseif ($clickAddUser)
	echo "Error: ".$userValid;

User::displayList();
?>

</body>
</html>

