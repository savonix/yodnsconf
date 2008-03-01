<?php
/*
Copyright (c) 2005, Till Brehm, projektfarm Gmbh
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of ISPConfig nor the names of its contributors
      may be used to endorse or promote products derived from this software without
      specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// TODO - replace this with MDB2

	class db
	{
		var $dbHost = "";		// hostname of the MySQL server
		var $dbName = "";		// logical database name on that server
		var $dbUser = "";		// database authorized user
		var $dbPass = "";		// user's password
		var $linkId = 0;		// last result of mysql_connect()
		var $queryId = 0;		// last result of mysql_query()
		var $record	= array();	// last record fetched
        var $autoCommit = 1;    // Autocommit Transactions
		var $currentRow;		// current row number
		var $errorNumber = 0;	// last error number
		var $errorMessage = "";	// last error message
		var $errorLocation = "";// last error location
		var $show_error_messages = false;

		// constructor
		function db()
		{
			
			global $conf;
			$this->dbHost = $conf["db_host"];
			$this->dbName = $conf["db_database"];
			$this->dbUser = $conf["db_user"];
			$this->dbPass = $conf["db_password"];
			//$this->connect();
		}

		// error handler
		function updateError($location)
		{
			$this->errorNumber = mysql_errno();
			$this->errorMessage = mysql_error();
			$this->errorLocation = $location;
			if($this->errorNumber && $this->show_error_messages)
			{
				echo('<br /><b>'.$this->errorLocation.'</b><br />'.$this->errorMessage);
				flush();
			}
		}

		function connect()
		{
			if($this->linkId == 0)
			{
				$this->linkId = mysql_connect($this->dbHost, $this->dbUser, $this->dbPass);
				if(!$this->linkId)
				{
					$this->updateError('DB::connect()<br />mysql_connect');
					return false;
				}
			}
			return true;
		}

		function query($queryString)
		{
			if(!$this->connect())
			{
				return false;
			}
			if(!mysql_select_db($this->dbName, $this->linkId))
			{
				$this->updateError('DB::connect()<br />mysql_select_db');
				return false;
			}
			$this->queryId = @mysql_query($queryString, $this->linkId);
			$this->updateError('DB::query('.$queryString.')<br />mysql_query');
			if(!$this->queryId)
			{
				return false;
			}
			$this->currentRow = 0;
			return $this->queryId;
		}

		// returns all records in an array
		function queryAllRecords($queryString)
		{
			if(!$this->query($queryString))
			{
				return false;
			}
			$ret = array();
			while($line = $this->nextRecord())
			{
				$ret[] = $line;
			}
			return $ret;
		}

		// returns one record in an array
		function queryOneRecord($queryString)
		{
			if(!$this->query($queryString) || $this->numRows() == 0)
			{
				return false;
			}
			return $this->nextRecord();
		}

		// returns the next record in an array
		function nextRecord()
		{
            $this->record = mysql_fetch_assoc($this->queryId);
			$this->updateError('DB::nextRecord()<br />mysql_fetch_array');
			if(!$this->record || !is_array($this->record))
			{
				return false;
			}
			$this->currentRow++;
			return $this->record;
		}

		// returns number of rows returned by the last select query
		function numRows()
		{
			return mysql_num_rows($this->queryId);
		}
		
		function affectedRows()
		{
			return mysql_affected_rows($this->linkId);
		}
		
		// returns mySQL insert id
		function insertID()
		{
			return mysql_insert_id($this->linkId);
		}
        
        // Check der variablen
		// deprecated, now use quote
        function check($formfield)
        {
            return $this->quote($formfield);
        }
		
		// Check der variablen
        function quote($formfield)
        {
            return addslashes($formfield);
        }
		
		// Check der variablen
        function unquote($formfield)
        {
            return stripslashes($formfield);
        }
		
		function toLower($record) {
			if(is_array($record)) {
				foreach($record as $key => $val) {
					$key = strtolower($key);
					$out[$key] = $val;
				}
			}
		return $out;
		}
       
       
       function insert($tablename,$form,$debug = 0)
       {
         if(is_array($form)){
	       foreach($form as $key => $value) 
   		    {
   		    $sql_key .= "$key, ";
            $sql_value .= "'".$this->check($value)."', ";
      		 }
       	$sql_key = substr($sql_key,0,strlen($sql_key) - 2);
        $sql_value = substr($sql_value,0,strlen($sql_value) - 2);
        
       	$sql = "INSERT INTO $tablename (" . $sql_key . ") VALUES (" . $sql_value .")";
       
      		 if($debug == 1) echo "SQL-Statement: ".$sql."<br><br>";
      		 $this->query($sql);
      		 if($debug == 1) echo "mySQL Error Message: ".$this->errorMessage;
          }
       }
       
       function update($tablename,$form,$bedingung,$debug = 0)
       {
       
	     if(is_array($form)){
           foreach($form as $key => $value) 
   		    {
   		    $insql .= "$key = '".$this->check($value)."', ";
      		 }
       	        $insql = substr($insql,0,strlen($insql) - 2);
       	        $sql = "UPDATE $tablename SET " . $insql . " WHERE $bedingung";
      		 if($debug == 1) echo "SQL-Statement: ".$sql."<br><br>";
      		 $this->query($sql);
      		 if($debug == 1) echo "mySQL Error Message: ".$this->errorMessage;
           }
       }

	}

?>