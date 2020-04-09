<?php
	$action=$_POST["action"];
	$servername="localhost";
	$username="root";
	$password="";
	$dbname="E-exam";
	$dsn='mysql:host=localhost;dbname=E-exam';
	try{
		$db=new PDO($dsn,$username,$password);
	//	echo "connection"."\n";
	}
	catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
	}
	$a=array();
	if ($action=="signupstudent"){
		$nationalid=$_POST['nationalid'];
		$collageid=$_POST['collageid'];
		$name=$_POST['name'];
		$password=$_POST['password'];
		$level=$_POST['level'];
		$department=$_POST['department'];
		signupstudent($nationalid,$collageid,$name,$password,$level,$department);
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		check_your_email_and_password($email);
	}else if ($action=="getstudentsubject"){
		$level=$_POST['level'];
		getstudentsubject($level);
	}else if ($action=="get_the_queationtrue_and_false"){
		get_the_queationtrue_and_false();
	}else if ($action=="get_the_queation_mcq"){
		get_the_queation_mcq();
	}else if ($action=="get_exam_queation_mcq"){
		get_exam_queation_mcq();
	}else if ($action=="get_exam_queationtrue_and_false"){
		get_exam_queationtrue_and_false();
	}
	function get_exam_queation_mcq(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_mcq;") as $result){
   			$a[]=$result;
		}
		foreach ($db->query("SELECT * FROM queastion_true_and_false ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function get_exam_queationtrue_and_false(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_true_and_false ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}

	function get_the_queation_mcq(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_mcq WHERE bank='true';") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function get_the_queationtrue_and_false(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_true_and_false WHERE bank='true';") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	
	function getstudentsubject($level){
		global $db;
   		foreach ($db->query("SELECT * FROM Subject WHERE level='$level'  ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	
	function check_your_email_and_password($email){
    	global $db;
    	foreach ($db->query("SELECT * FROM Student WHERE Collageid='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}
	function signupstudent($nationalid,$collageid,$name,$password,$level,$department){
		global $db;
		try{
			$state=$db->prepare("INSERT INTO Student(Nationalid,Collageid,name,password,level,department)VALUES('$nationalid','$collageid','$name','$password','$level','$department')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	

?>