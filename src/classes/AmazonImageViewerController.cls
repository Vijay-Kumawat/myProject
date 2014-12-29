/**
 *  Purpose         :   Controller class for AmazonImageViewerPage
 * 
 *  Created By      :   Vijay Kumawat
 * 
 *  Created Date    :   07/11/2014
 * 
 *  Revision Logs   :   V_1.0 - Created
 * 
 **/
public class AmazonImageViewerController {
  
  //Hold Bucket Name at Amazon S3 Server
  public String bucketName{get; set;}
  
  //Hold List of Object from BucketList of Amazon S3 server
  public S3.ListEntry[] bucketList {get; set;}
  
  //hold Each Object Information returned from Amazon Web Server S3
  public List<Obj> objList{get; set;}
  
  //Decide show object list on page or not
  public Boolean showObjList{get; set;}
  public Boolean showMainPanel {get; set;}
  
  //Pagination Properties
  public Integer pageSize{get; set;}
  public Integer currentPage{get; set;}
  public String currentPageInfo{get; set;}
  public Integer totalRecords;
  public Integer pageNumber;
    
  //For disabling pagination links
    public Boolean showPrevious{get; set;}
    public Boolean showNext{get; set;}
    
    //Email Properties
    public Boolean ShowEmailPanel {get; set;}
    public String ToAddress {get; set;}
    public String CCAddress {get; set;}
    public String Subject {get; set;}
    public String emailBody {get; set;}
    
    //Hold Task Id
    public Id dashboardTaskId{get;set;}
    
    //Hold File size for particular Task
    public Integer AllFileSize {get;set;}
    
    //Hold Unique folder Name for Each Task
    public String folderName{get; set;}
    
    //Hold attached files to Amazon
    List<Obj> AttachmentsFiles ;
    
    public Boolean ShareLink {get;set;}
    
    public AmazonImageViewerController(ApexPages.StandardController controller){}
    
    String key;
    String Secret;
    public S3.AmazonS3 as3;
    
  public AmazonImageViewerController(){
    
    	showMainPanel = true ;
        showObjList = false ;
        
        //Initialize Bucket Name required to Get Files from particular bucket at amazon server
        bucketName = 'AjeliteUploadedFiles';
        
        //Get Task ID from Page Parameters
        Id accountId = (Id)apexpages.currentpage().getparameters().get('Id');
        
        //Get Unique folder name for each task
        folderName = String.valueOf(accountId).left(15)+'/';
        showAllFiles();
  }
  
  /**
     *  @description    :   This method is to get Files from Amazon web server using Web Service Callout
     *
     *  @args           :
     *
     *  @return         :   void
     *
     **/
  public void amazonFileCount(){
    
    	Integer maxNumberToList = 10000; //Set the number of Objects to return for a specific Bucket
        String Prefix = '001'; //Limits the response to keys that begin with the indicated prefix. You can use prefixes to separate a bucket into different sets of keys in a way similar to how a file system uses folders. This is an optional argument.
        String Marker = null; //Indicates where in the bucket to begin listing. The list includes only keys that occur alphabetically after marker. This is convenient for pagination: To get the next page of results use the last key of the current page as the marker. The most keys you'd like to see in the response body. The server might return less than this number of keys, but will not return more. This is an optional argument.
        String Delimiter = null; //Causes keys that contain the same string between the prefix and the first occurrence of the delimiter to be rolled up into a single result element in the CommonPrefixes collection. These rolled-up keys are not returned elsewhere in the response.
        
        AmazonKey__c S3Credentials = AmazonKey__c.getValues('Key01');
    
        key = S3Credentials.key__c ;
        Secret = S3Credentials.Secret__c ;
        as3 = new S3.AmazonS3( key , Secret);
        Datetime now = Datetime.now(); 
        S3.ListEntry[] bucketList;
        
        if (test.isRunningTest()) {
             
        }else{
            S3.ListBucketResult objectsForBucket = as3.ListBucket('AjeliteUploadedFiles', Prefix, Marker,maxNumberToList, Delimiter,as3.key,now,as3.signature('ListBucket',now),as3.secret);
            bucketList = objectsForBucket.Contents;
        }
    
        //Initialize List
        AttachmentsFiles = new List<Obj> ();
        
        //Check for Bucket List Size
        if( bucketList != null && bucketList.size() > 0 ){
          
          //Loop over each Response
          for (S3.ListEntry s3: bucketList) {
            
            //Get Key name of File from Amazon Returned Response
            String keyname = s3.Key ;
            System.debug('Check for KeyName *************** ' + keyname);
            System.debug('Check for FolderName *************** ' + folderName);
            if(keyname.startsWith(folderName)){
              
              //Instantiating wrapper class hold each response property of particular file
              Obj tmp = new Obj();
              tmp.key = s3.Key;
	          tmp.Name = keyname.substringAfterlast('/');
	          tmp.UploadDate = s3.LastModified ;
	          tmp.FileSizeDetail = s3.Size+' Bytes';
	          tmp.sharelink = false;
          
	          //Calculating File size
	          Decimal KB;
	          if ( s3.Size >= 1024 ) {
	            KB = s3.Size/1024 ; 
	            tmp.FileSizeDetail = KB.round()+' KB' ;
	          }
	          if ( KB >= 1024 ) {
	            tmp.FileSizeDetail = (KB/1024).round()+' MB';
	          }
	          
	          //Creating Object Url
	          tmp.objectURL  = 'https://s3.amazonaws.com/'+bucketName+'/'+s3.Key ; 
          
	          //Reget S3 Actual File Name
	          String name = s3.key ; 
          
	          //Setting File Type
	          if( name.endsWithIgnoreCase('pdf') ){
		                tmp.filetype = 'pdf';
		            }else if( name.endsWithIgnoreCase('xls') || name.endsWithIgnoreCase('xlsx') || name.endsWithIgnoreCase('csv')){
		                tmp.filetype = 'xls';
		            }else if( name.endsWithIgnoreCase('zip') ){       
		                tmp.filetype = 'zip';
		            }else if( name.endsWithIgnoreCase('doc') || name.endsWithIgnoreCase('docx') ||  name.endsWithIgnoreCase('DOC') || name.endsWithIgnoreCase('txt')){
		                tmp.filetype = 'doc';
		            }else if( name.endsWithIgnoreCase('jpg') || name.endsWithIgnoreCase('png') ||  name.endsWithIgnoreCase('jpeg') || name.endsWithIgnoreCase('gif') ){
		                tmp.filetype = 'pic';
		            }else if( name.endsWithIgnoreCase('ppt') || name.endsWithIgnoreCase('pptx') ){
		                tmp.filetype = 'ppt';
		            }
		            
		            System.debug('Check for Each File Properties ::::::::::::: ' + tmp);
		            
		            //Add each file with it property In wrapper to List
		            AttachmentsFiles.add(tmp);
		            AllFileSize = AttachmentsFiles.size();
	            }
	          }
        }
  }
  
  /**
     *  @description    :   This method is to get Files from Amazon web server using Web Service Callout and set pagination  property
     *
     *  @args           :
     *
     *  @return         :   void
     *
     **/
  public void showAllFiles(){
    
    showMainPanel = true;
    showObjList = false;
    
         //Set Amazon Bucket Name and Folder Name
         bucketName = 'AjeliteUploadedFiles'; // Bucket Name

         // get Amazon File Counts
         amazonFileCount();
         
         //Initialize Obj Wrapper List will hold all Responses and usedd to Show List on Page
         objList = new List<Obj> ();
         
         //Assigne Attachement File List 
         objList = AttachmentsFiles;  
                
         if(objList != null && objList.size()>0){
           
           //Sort Object List by Date in Desc order
           objList.sort();
           
           //This will decide to show list on page or not
           showObjList = true;
  		}
  }
 
  /**
     *  @description    :   This method is used to Delete Selecte files from Amazon Server
     *
     *  @args           :
     *
     *  @return         :   void
     *
     **/
     public void deleteObjects(){
       
       //Set Current Time Stamp
       Datetime now = Datetime.now();
       
       //List to hold delete key string
       List<String> deleteKeyString = new List<String>();
       
       //Check for ObjectList is Not null
       if(objList != null  && objList.size() > 0) { 
         
         //Temp variable to check if Any file selected for delete if selected then count should be greater then zero
         Integer delCount = 0;
         
         //Iterate over on current List
         for ( Obj O: objList) {
           
           //Check for Selected Object
           if(O.Sel != null && O.Sel){
             
             /*System.Debug(' O.Sel ==>  ' + O.Sel ); 
             
             try{
             	
             	AmazonKey__c S3Credentials = AmazonKey__c.getValues('Key01');
    
		        key = S3Credentials.key__c ;
		        Secret = S3Credentials.Secret__c ;
		        as3 = new S3.AmazonS3( key , Secret);
		        Datetime now1 = Datetime.now(); 
		       
                if (test.isRunningTest()) {
		        
		        }else{
		            S3.Status delObjReslt = as3.DeleteObject('AjeliteUploadedFiles',O.Key,as3.key,now1,as3.signature('DeleteObject',now1),as3.secret);
		        } 
		        
		        
		        
		        
                delCount++;
             }catch(Exception e){
               ApexPages.addMessages(e);
             }
           }*/  
           
           		deleteKeyString.add(O.Key);
			}
     		}
         
         	
           	AmazonS3Util.S3MultiDeleteResponse resp = new AmazonS3Util.S3MultiDeleteResponse();
         	AmazonS3Util.DeleteMultipleObjectRequest req = new AmazonS3Util.DeleteMultipleObjectRequest(deleteKeyString);
         	
         	String reqXmlBody = req.getXmlSource();
    		System.debug(Logginglevel.WARN, 'deleteMultiObject. REQUEST BODY ---> ' + reqXmlBody);
    		
    		// The base64 encoded 128-bit MD5 digest of the message (without the headers)
		    string md5XmlBody = AmazonS3Util.makeMD5(reqXmlBody);
		    // Length of the message (without the headers)
		    //string contentLength = String.valueOf(AmazonS3Util.getByteLength(reqXmlBody));
		    // The current date and time (Example: Wed, 01 Mar 2009 12:00:00 GMT.)
		    string dateString = AmazonS3Util.getDateNowString();
		    
		    string stringToSign = 'POST\n'                           // HTTP-Verb
                        + md5XmlBody + '\n'                  // Content-MD5
                        + 'text/xml\n'                       // Content-Type
                        + dateString + '\n'                  // Date
                        + ''                                 // CanonicalizedAmzHeaders
                        + '/' + 'AjeliteUploadedFiles' + '/?delete'; // CanonicalizedResource
 
		    system.debug(Logginglevel.WARN, 'deleteMultiObject ---> stringToSign ---> ' + stringToSign);
		 
		    string signedString = AmazonS3Util.makeSign(stringToSign, 'i3bc/ZXz1MyyKrU+0w9JA0/SunGUY+hBG/4vSSrC');
		 
		    URL url = new URL('https://s3.amazonaws.com');
		    string host = url.getHost();
		 	
		    string endPointUrl = 'https://s3.amazonaws.com' + '/?delete/';
		    
		    HttpRequest con = new HttpRequest();
		    con.setEndPoint(endPointUrl);
		    System.debug('@@@@@@@@@@' + signedString);
		    con.setHeader('Authorization','AWS ' + 'AKIAIM5CBG3WFLLZBTAA' +':' + signedString);
		    con.setHeader('Host', host);
		    con.setHeader('Date', dateString);
		    con.setHeader('content-type', 'text/xml');
		    //con.setHeader('Content-Length', contentLength);
		    con.setHeader('Content-MD5', md5XmlBody);
		 
		    con.setMethod('POST');
		    con.setBody(reqXmlBody);
		 	System.debug('#########3' + con);
		    Http http = new Http();
		    HTTPResponse res = http.send(con);
		    
		    integer   statusCode   =   res.getStatusCode ( ) ; 
     		string   resBody   =    res.getBody(); 
     		system.debug ( Logginglevel.WARN ,   'deleteMultiObject STATUS CODE:'   +   statusCode   +   'RES.GETBODY: '   +   resBody   +   ' RES.GETSTATUS: '   +   res.getStatus()   +   ' CON.GETENDPT: '   +   con.getEndPoint()); 
         }}
     
  public void renderShareLink(){
       System.Debug(' /***** objList ==> ' + objList );
       
       if(objList != null && objList.size()>0){
          for ( Obj file: objList) { 
            
            System.debug('Check for Each Object :::::::::::::::::: ' + file); 
        if(file.Sel != null && file.Sel){
          file.sharelink = true;
          ShareLink =  true; 
        } else {
          file.sharelink = false; 
        }
          }
       }
       
       System.debug('@@@@@Share Link' + ShareLink);
    }
    
    public void refreshObject(){
      
      ShareLink = false;
      showAllFiles();
    }
    
    public void renderemail () {
        showMainPanel = false ;
        ShowEmailPanel = true ;
        
        Subject  = 'Storage Files';
        //Body  = '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n';
        emailBody = 'Dear    ,'+'\n\n\n\n' ;
        
        if(objList != null && objList.size()>0){
          for ( Obj O: objList) {  
               if(O.Sel != null && O.Sel){
                // Body  = Body + O.objectURL +'\n';
                 emailBody  = emailBody + O.Name +' : '+ O.objectURL + '\n' ;
               }
          }
        }
        
        emailBody = emailBody +'\n \n'+ 'Marc Carpenter' +'\n'+ 'Allison James Estates & Homes '+'\n'+ 'San Diego Central Office ' +'\n'+ 'Office: 858-309-4799' +'\n';
    }
    public void sendEmail () {
        
        System.Debug(' /***** sendEmail ()  ****/ ' ); 
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        System.Debug(' /***** ToAddress ==> ' + ToAddress );  
        
        list<String> toAddresses = new list<String> () ;
        list<String> ccAddresses = new list<String> () ;
      
        if(ToAddress!=NULL && ToAddress.trim() != '') {
          
      toAddresses =ToAddress.split(',', 0);
      mail.setToAddresses(toAddresses);
        }
        if(CCAddress!=NULL && CCAddress.trim() != '') {
          
      ccAddresses=CCAddress.split(',', 0);
      mail.setCcAddresses(ccAddresses);
        }
        
        System.Debug(' /***** toAddresses ==> ' + toAddresses );  
        
        mail.setSenderDisplayName('Marc Carpenter');
        mail.setSubject(Subject);
        
        mail.setPlainTextBody(emailBody);
        //mail.setHtmlBody(Body);
        
        try{
          
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }catch(Exception e){
          
        }
        
        showMainPanel = true ;
        ShowEmailPanel = false ;
    }
  public void cancel () {
        showMainPanel = true ;
        ShowEmailPanel = false ;             
    }
    
    //create signature
	public String getCloudbeesSignature(String endPointUrl, String secret){
	
		String algorithmName = 'HMacSHA1';
		Blob mac = Crypto.generateMac(algorithmName,  Blob.valueOf(endPointUrl),Blob.valueOf(secret));
		String macUrl = EncodingUtil.base64Encode(mac);
		return macUrl;
	}

    private String getURLEncodedString(String strValue) {
        strValue = Encodingutil.urlEncode(strValue, 'UTF-8');
        return strValue;
    }


    private String getTimeoutGmt(String s3Action) {
        String timeoutGmt = '';
            timeoutGmt = Datetime.now().addMinutes(10).formatGmt('yyyyMMddHHmmss');

        //return timeoutGmt
        return timeoutGmt;
    }

    // method to send GET request
    public HttpResponse executeGet(String sUrl){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(sUrl);
        req.setMethod('GET');
        req.setTimeout(60000);
        HttpResponse res;
        if(!Test.isRunningTest()){
            res = h.send(req);
        }
        else{
             res = new HttpResponse();
        }
        return res;
    }   
}