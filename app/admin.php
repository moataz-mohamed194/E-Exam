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
	if($action=="getadmindata"){
		getrequestdata();
	}else if($action=="getsubject"){
		getsubject();
	}else if($action=="getadmindata2"){
		getadmindata();
	}else if($action=="getprofessordata"){
		getprofessordata();
	}else if ($action=="send_request") {
		$table=$_POST['type'];
		$nationalid=$_POST['Nationalid'];
		$email=$_POST['Email'];
		$password=$_POST['Password'];
		$name=$_POST['realName'];
		$graduted=$_POST['graduted'];
		$age=$_POST['age'];
		send_request($table, $name,$email,$nationalid,$password, $graduted, $age);
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		check_your_email_and_password($email);
	}else if ($action=="rejected"){
		$id=$_POST['id'];
		rejected($id);
	}else if ($action=="accept"){
		$id=$_POST['id'];
		$type=$_POST['type'];
		$nationalid=$_POST['Nationalid'];
		$email=$_POST['Email'];
		$password=$_POST['Password'];
		$realName=$_POST['realName'];
		$graduted=$_POST['graduted'];
		$age=$_POST['age'];
		accept($nationalid, $email,$realName,$password,$id,$graduted,$age,$type);
	}else if ($action=="add_department"){
		$name=$_POST['name'];
		$whenstart=$_POST['whenstart'];
		$leader=$_POST['leader'];
		add_department($name, $whenstart,$leader);
	}else if ($action=="addsubject"){
		$name=$_POST['name'];
		$department=$_POST['department'];
		$professor=$_POST['professor'];
		$level=$_POST['level'];
		$semester=$_POST['semester'];
		addsubject($name, $department,$professor,$level,$semester);
	}else if($action=="getdepartmentdata"){
		getdepartmentdata();
	}else if ($action=="updatesubject"){
		$name=$_POST['name'];
		$department=$_POST['department'];
		$level=$_POST['level'];
		$semester=$_POST['semester'];
		$professor=$_POST['professor0000'];
		$id=$_POST['id'];
		updatesubject($name,$department,$professor,$level,$semester,$id);
	}

																					
	function updatesubject($name,$department,$professor,$level,$semester,$id){
		global $db;
		if($name!=null){
	   		$db->query("UPDATE Subject SET Name='".$name."' WHERE id=".$id);			
		}
		if($semester!=null){
	   		$sql = "UPDATE Subject SET semester='$semester' WHERE id=$id";	
	   		$db->query($sql);		
		}
		if($level!=null){
	   		$sql = "UPDATE Subject SET level='$level' WHERE id=$id";	
	   		$db->query($sql);		
		}
	   		
		if($professor!=null){
			global $db;
		   	$sql = "UPDATE Subject SET professor='$professor' WHERE id=$id";	
	   		$db->query($sql);		
		}
		if($department!=null){
			global $db;
	   		$sql = "UPDATE Subject SET department='$department' WHERE id=$id";	
	   		$db->query($sql);		
		}
	}
	function getadmindata(){
		global $db;
   		foreach ($db->query("SELECT * FROM Admin") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}	
	function getrequestdata(){
		global $db;
   		foreach ($db->query("SELECT * FROM request") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function getdepartmentdata(){
		global $db;
   		foreach ($db->query("SELECT * FROM Department") as $result){
			$a[]=$result;
		}
		echo json_encode($a);
	}
	function getsubject(){
		global $db;
   		foreach ($db->query("SELECT * FROM Subject") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function getprofessordata(){
		global $db;
   		foreach ($db->query("SELECT * FROM Professor") as $result){
			$a[]=$result;
		}
		echo json_encode($a);
	}
	function send_request($table, $name,$email,$nationalid,$password, $graduted, $age){
		global $db;
		try{
			$state=$db->prepare("INSERT INTO request(type,Nationalid,Email,Password,realName,graduted,age)VALUES('$table',$nationalid,'$email','$password','$name','$graduted',$age)");
			$state->execute();
    		echo "Done";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	function check_your_email_and_password($email){
    	global $db;
    	foreach ($db->query("SELECT * FROM Admin WHERE Email='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}
	function rejected($id){
		global $db;
   		try{
			$sql="DELETE FROM request WHERE ID='$id'";
			$db->query($sql);
			echo "dooneee";		
		}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
		}
	}
	function accept($nationalid, $email,$realName,$password,$id,$graduted,$age,$type){
		global $db;
		if ($type == 'Professor') {

			try{
			$state=$db->prepare("INSERT INTO Professor(Nationalid,Email,Password,realName,graduted,age)VALUES($nationalid,'$email','$password','$realName','$graduted',$age)");
				
			$state->execute();
    		
				$sql="DELETE FROM request WHERE ID='$id'";
				$db->query($sql);
				echo "doone";
			}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
			}
    	} else if ($type == 'Admin') {
    		try{
				$state=$db->prepare("INSERT INTO Admin(Nationalid,Email,Password,realName,graduted,age)VALUES($nationalid,'$email','$password','$realName','$graduted',$age)");
				$state->execute();
    			$sql="DELETE FROM request WHERE ID='$id'";
					$db->query($sql);
					echo "dooneee";
			}catch(PDOException $e){
				echo "failed"." ".$e->getMessage();
			}
	    }
	}
	function add_department($name, $whenstart,$leader){
		global $db;
		try{
			$state=$db->prepare("INSERT INTO Department(Name,whenstart,leader)VALUES('$name','$whenstart','$leader')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	function addsubject($name, $department,$professor,$level,$semester){
		global $db;
		try{
			$state=$db->prepare("INSERT INTO Subject(Name,department,professor,level,semester,counter)VALUES('$name','$department','$professor','$level','$semester','0')");
			$state->execute();
    		echo "Doned";
    	}catch(PDOException $e){
			echo "failed"." ".$e->getMessage();
		}
	}
	
	
	

?>