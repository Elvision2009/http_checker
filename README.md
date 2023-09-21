# http_checker

INSTALL
git clone  https://github.com/Elvision2009/http_checker/http_checker.sh
chmod +x http_checker.sh

USAGE
		This program check HTTP links and give response codes
		    Param:    Example:                Description
		    
        -f	      -f input_file.txt	      Choose file with links for check"
		    -m	      -m 200,301		          Choose status codes for match"
		    -o      	-o output_file.txt	    Choose output file"
 		    -c	      -c			                Checked links only. Without status codes"
		    -h	      -h			                This help"
		    
        Example:
		    ./checker.sh -f input.txt -o output.txt -m 200,301 -c"
		    
		    Check all links from file input.txt and output only links with statuse code 200 or 301 
		    into file output.txt without status codes in file. Don't use -c if you want to see status codes in output file!
