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
/*$a=array();
//		$aa=$db->query("SELECT * FROM Chapter WHERE chaptername='OOP';");
//		$a=$aa->execute();
//		echo $aa;
	}
	catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
	}
*/
	$a=array();
	//$data=array();
	if($action=="getProfessordata"){
		getProfessordata();
	}else if ($action=="check_your_email_and_password"){
		$email=$_POST['email'];
		check_your_email_and_password($email);
	}else if ($action=="get_the_subject"){
		$Professor=$_POST['Professor'];
		get_the_subject($Professor);
	}else if ($action=="add_chapter"){
		$subjectname=$_POST['subjectname'];
		$chaptername=$_POST['chaptername'];
		add_chapter($subjectname,$chaptername);
	}else if ($action=="getchapterdata"){
		getchapterdata();
	}else if ($action=="remove_chapter"){
		$subjectname=$_POST['subjectname'];
		$id=$_POST['id'];
		remove_chapter($subjectname,$id);
	}else if ($action=="add_question_true_and_false_tosqlite"){
		$question=$_POST['question'];
		$subject=$_POST['subject'];
		$numberofchapter=$_POST['numberofchapter'];
		$correctanswer=$_POST['correctanswer'];
		$bank=$_POST['bank'];
		add_question_true_and_false_tosqlite($question,$subject,$numberofchapter,$correctanswer,$bank);
	}else if ($action=="add_question_mcq_tosqlite"){
		$question=$_POST['question'];
		$subject=$_POST['subject'];
		$numberofchapter=$_POST['numberofchapter'];
		$level=$_POST['level'];
		$answer1=$_POST['answer1'];
		$answer2=$_POST['answer2'];
		$answer3=$_POST['answer3'];
		$answer4=$_POST['answer4'];
		$correctanswer=$_POST['correctanswer'];
		$bank=$_POST['bank'];
		add_question_mcq_tosqlite($question,$subject,$numberofchapter,$level,$answer1,$answer2,$answer3,$answer4,$correctanswer,$bank);
	}else if ($action=="get_the_queationtrue_and_false"){
		get_the_queationtrue_and_false();
	}else if ($action=="get_the_queation_mcq"){
		get_the_queation_mcq();
	}else if ($action=="remove_mcq_question"){
		$id=$_POST['id'];
		remove_mcq_question($id);
	}else if ($action=="queastion_true_and_false"){
		$id=$_POST['id'];
		queastion_true_and_false($id);
	}else if ($action=="add_detailsexam"){
		$subject=$_POST['subject'];
		$when=$_POST['when'];
		$time=$_POST['time'];
		$data=$_POST['data'];
		//$data=$data2;
		add_detailsexam($subject,$when,$time,$data);
		
	}else if ($action=="addchaptertoexam"){
		$examid=$_POST['examid'];
		$chapter=$_POST['chapter'];
		$level=$_POST['level'];
		$type=$_POST['type'];
		$count=$_POST['count'];
		addchaptertoexam($examid,$chapter,$level,$type,$count);

	}
	function addchaptertoexam($idexam,$chapter,$level,$type,$count) {
  		  global $db;
		$state=$db->prepare("INSERT INTO examchapter(examid,chapter,level,type,count)VALUES('$idexam','$chapter','$level','$type','$count')");
		$state->execute();
		
  }

	function add_detailsexam($subject,$when,$time,$data){
		global $db;
		$state=$db->prepare("INSERT INTO examdetails(subject,whenstart,time)VALUES('$subject','$when','$time')");
		$state->execute();
		$add = $db->lastInsertId();
		echo $add;
	 	 /* $data1=array_map($data);
	 	  //	echo $data[];
//	 	  	echo $data1[0];
	 	echo $data1["chapter1trueandfalse"];
/*	 	if($data["chapter1trueandfalse"]!=null){
	 		addchaptertoexam("$add", "1", "null", "trueandfalse", $data["chapter1trueandfalse"]);
	 	}if($data["chapter2trueandfalse"]!=null){
	 		addchaptertoexam("$add", "2", "null", "trueandfalse", $data["chapter2trueandfalse"]);
	 	}if($data["chapter3trueandfalse"]!=null){
	 		addchaptertoexam("$add", "3", "null", "trueandfalse", $data["chapter3trueandfalse"]);
	 	}if($data["chapter4trueandfalse"]!=null){
	 		addchaptertoexam("$add", "4", "null", "trueandfalse", $data["chapter4trueandfalse"]);
	 	}if($data["chapter5trueandfalse"]!=null){
	 		addchaptertoexam("$add", "5", "null", "trueandfalse", $data["chapter5trueandfalse"]);
	 	}if($data["chapter1mcqa"]!=null){
	 		addchaptertoexam("$add", "1", "A", "mcq",$data["chapter1mcqa"]);
	 	}if($data["chapter1mcqb"]!=null){
	 		addchaptertoexam("$add", "1", "B", "mcq",$data["chapter1mcqb"]);
	 	}if($data["chapter1mcqc"]!=null){
	 		addchaptertoexam("$add", "1", "C", "mcq",$data["chapter1mcqc"]);
	 	}
	 	if($data["chapter2mcqa"]!=null){
	 		addchaptertoexam("$add", "2", "A", "mcq",$data["chapter2mcqa"]);
	 	}if($data["chapter2mcqb"]!=null){
	 		addchaptertoexam("$add", "2", "B", "mcq",$data["chapter2mcqb"]);
	 	}if($data["chapter2mcqc"]!=null){
	 		addchaptertoexam("$add", "2", "C", "mcq",$data["chapter2mcqc"]);
	 	}
	 	if($data["chapter3mcqa"]!=null){
	 		addchaptertoexam("$add", "3", "A", "mcq",$data["chapter3mcqa"]);
	 	}if($data["chapter3mcqb"]!=null){
	 		addchaptertoexam("$add", "3", "B", "mcq",$data["chapter3mcqb"]);
	 	}if($data["chapter3mcqc"]!=null){
	 		addchaptertoexam("$add", "3", "C", "mcq",$data["chapter3mcqc"]);
	 	}

	 	if($data["chapter4mcqa"]!=null){
	 		addchaptertoexam("$add", "4", "A", "mcq",$data["chapter4mcqa"]);
	 	}if($data["chapter4mcqb"]!=null){
	 		addchaptertoexam("$add", "4", "B", "mcq",$data["chapter4mcqb"]);
	 	}if($data["chapter4mcqc"]!=null){
	 		addchaptertoexam("$add", "4", "C", "mcq",$data["chapter4mcqc"]);
	 	}

	 	if($data["chapter5mcqa"]!=null){
	 		addchaptertoexam("$add", "5", "A", "mcq", $data["chapter5mcqa"]);
	 	}if($data["chapter5mcqb"]!=null){
	 		addchaptertoexam("$add", "5", "B", "mcq", $data["chapter5mcqb"]);
	 	}if($data["chapter5mcqc"]!=null){
	 		addchaptertoexam("$add", "5", "C", "mcq", $data["chapter5mcqc"]);
	 	}*/

	}

	function queastion_true_and_false($id){
		global $db;
		$sql="DELETE FROM queastion_true_and_false WHERE ID='$id'";
		$db->query($sql);
	}
	function remove_mcq_question($id){
		global $db;
		$sql="DELETE FROM queastion_mcq WHERE ID='$id'";
		$db->query($sql);
	}
	function get_the_queation_mcq(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_mcq ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function get_the_queationtrue_and_false(){
		global $db;
   		foreach ($db->query("SELECT * FROM queastion_true_and_false ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function add_question_mcq_tosqlite($question,$subject,$numberofchapter,$level,$answer1,$answer2,$answer3,$answer4,$correctanswer,$bank){
		global $db;
		$state=$db->prepare("INSERT INTO queastion_mcq(Question,subject,numberofchapter,level,answer1,answer2,answer3,answer4,correctanswer,bank)VALUES('$question','$subject','$numberofchapter','$level','$answer1','$answer2','$answer3','$answer4','$correctanswer','$bank')");
			$state->execute();
	}
	function add_question_true_and_false_tosqlite($question,$subject,$numberofchapter,$correctanswer,$bank){
		global $db;
		$state=$db->prepare("INSERT INTO queastion_true_and_false(Question,subject,numberofchapter,correctanswer,bank)VALUES('$question','$subject','$numberofchapter','$correctanswer','$bank')");
			$state->execute();
	}
	function remove_chapter($subjectname,$id){
		try{
		global $db;
		$sql="DELETE FROM Chapter WHERE ID='$id'";
		$db->query($sql);
			
		foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$subjectname';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];
		$db->query("UPDATE Subject SET counter=$s WHERE Name='$subjectname'");
		echo "done";
	}
		catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
		}		
	}
	function getchapterdata(){
		global $db;
   		foreach ($db->query("SELECT * FROM Chapter ;") as $result){
   			$a[]=$result;
		}

		echo json_encode($a);
	}
	function add_chapter($subjectname,$chaptername){
		try{
		global $db;
		$state=$db->prepare("INSERT INTO Chapter(subjectname,chaptername)VALUES('$chaptername','$subjectname')");
			$state->execute();

		foreach ($db->query("SELECT COUNT(*) FROM Chapter WHERE subjectname='$chaptername';") as $result){
   			$a[]=$result;
		}
		json_encode($a);
		$s=$a[0]['COUNT(*)'];
		echo $s;
		$db->query("UPDATE Subject SET counter=$s WHERE Name='$chaptername'");
		echo "done";
	}
		catch(PDOException $e){
		echo "failed"." ".$e->getMessage();
		}		
	}
	function get_the_subject($Professor){
		global $db;
   		foreach ($db->query("SELECT * FROM Subject WHERE professor='$Professor'  ;") as $result){
   			$a[]=$result;
		}
		echo json_encode($a);
	}
	function getProfessordata(){
		global $db;
   		foreach ($db->query("SELECT * FROM Professor ;") as $result){
   			$a[]=$result;
		}

		echo json_encode($a);
	}	
	function check_your_email_and_password($email){
    	global $db;
    	foreach ($db->query("SELECT * FROM Professor WHERE Email='$email'") as $result) {
    		$a[]=$result;
		}
		echo json_encode($a);
	}

?>