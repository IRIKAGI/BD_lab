--DROP TABLESPACE TS_LOB;
CREATE TABLESPACE TS_LOB
  DATAFILE 'D:\oracledb\tablespaces\TS_LOB.dbf'
  SIZE 30M
  AUTOEXTEND ON NEXT 10M
  MAXSIZE 200M
  EXTENT MANAGEMENT LOCAL;

CREATE USER lob_user IDENTIFIED BY Pa$$w0rd
  DEFAULT TABLESPACE TS_LOB
  ACCOUNT UNLOCK;
  
GRANT CREATE SESSION,
      CREATE TABLE,
      CREATE VIEW,
      CREATE PROCEDURE TO lob_user;
      
GRANT CREATE ANY DIRECTORY,
      DROP ANY DIRECTORY TO lob_user;
      
ALTER USER lob_user QUOTA 100M ON TS_LOB;

-- lob_user
--DROP DIRECTORY BFILE_DIR;
CREATE DIRECTORY BFILE_DIR as 'D:/BFILE_DIR';
GRANT READ ON DIRECTORY BFILE_DIR TO lob_user
--DROP TABLE lob_table;
CREATE TABLE lob_table (
  id   NUMBER(5)  PRIMARY KEY,
  FOTO BLOB NOT NULL
)

SELECT * FROM lob_table;

DECLARE
  l_blob BLOB; 
  v_src_loc  BFILE;
  v_amount   INTEGER;
BEGIN
  v_src_loc := BFILENAME('BFILE_DIR', 'paradrop.png');
  INSERT INTO lob_table  
  VALUES (1, empty_blob()) RETURN FOTO INTO l_blob; 
  DBMS_LOB.FILEOPEN(v_src_loc, DBMS_LOB.LOB_READONLY);
  v_amount := DBMS_LOB.GETLENGTH(v_src_loc);
  DBMS_LOB.LOADFROMFILE(l_blob, v_src_loc, v_amount);
  DBMS_LOB.FILECLOSE(v_src_loc);
  COMMIT;
END;
-----
--DROP TABLE bfile_table;
CREATE TABLE bfile_table (
 name VARCHAR(255),
 fff BFILE 
)

INSERT INTO bfile_table VALUES ( 'doc', BFILENAME( 'BFILE_DIR', 'test.docx' ) );
SELECT * FROM bfile_table;
