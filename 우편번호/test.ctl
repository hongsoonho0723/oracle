LOAD DATA 
        INFILE 'zipcode.csv' 
        APPEND 
        INTO TABLE zipcode
        FIELDS TERMINATED BY ','
(zip,sido,si,dong,ri,doseo,bunji,apt,address)   
