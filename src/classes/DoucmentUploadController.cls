/*
* Description   :	This is class there to upload document and also create custom setting record.
* 
* Created By    :	Vijay Kumar Kumawat
*
* Created Date  :	10/09/2012
*
* Version       :	V_1.0 - Created 
*/

public class DoucmentUploadController {
	
	//Document Instance
	public Document document {get; set;}
	public String uRL {get; set;}
	public Boolean hasImage {get; set;}
	
	//Constructr Calling
	public DoucmentUploadController() {
		
		//Initialization
		document = new Document();
		uRL = '';
		hasImage = false;	
	}
	
	//This method is for save Document record
	public void saveDocument() {
		
		//try block
		try {
		
			//Check for null
			if(document.Body != null) {
				
				//Assign Into Current Logged In User Folder
				document.FolderId = UserInfo.getUserId();
				document.IsPublic = true;
				
				//Insert Document
				insert document;
				
				//String to hold image URL
				String imageURL = '/servlet/servlet.FileDownload?file=' + document.Id;
				
				//Set Flag Value
				hasImage = true;

				Agent_Signature__c aSig = Agent_Signature__c.getInstance(UserInfo.getUserId());
					aSig.Image_URL__c = imageURL;
				
				upsert aSig;
			}
		}
		catch(Exception e) {
			
			//Add Error On Page
			ApexPages.addMessages(e);
		}
		finally {
	      document.Body = null;
	      document = new Document();
	    }
	}
}