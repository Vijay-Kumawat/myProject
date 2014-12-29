public   class   AmazonS3Util   { 
 

   public   class   AmazonS3Exception   extends   Exception   { 
 
   } 
 

   public   static   string   getDateNowString ( )   { 
     return   Datetime.now().formatGmt('EEE, dd MMM yyyy HH:mm:ss Z'); 
   } 
 

   public   static   string   makeSign ( string   inputString ,   string   secret )   { 
     String   macUrl   ; 
     String   signingKey   =   EncodingUtil.base64Encode ( Blob.valueOf ( secret ) ) ; 
     Blob  mac   =   Crypto.generateMac ( 'HMacSHA1' ,   Blob.valueof ( inputString ) , Blob.valueof ( Secret ) ) ; 
     macUrl   =   EncodingUtil.base64Encode ( mac ) ; 
     return   macUrl ; 
   } 
 
   public   static   string   makeMD5 ( string   source )   { 
     
     Blob   b   =   Blob.valueOf ( source ) ; 
     // return EncodingUtil.convertToHex(Crypto.generateDigest('MD5', b)); // --> 400 The Content-MD5 you specified was invalid 
     return   EncodingUtil.base64Encode ( Crypto.generateDigest ( 'MD5' ,   b ) ) ; 
   }
 
 
   /*******************************************************************************/ 
   /** AmazonS3のレスポンスを表す ****************************************************/ 
   /*******************************************************************************/ 
   public   interface   S3Response   { 
     void   setStatusCode ( integer   statusCode ) ; 
     void   setResponse ( string   xmlSource ) ; 
   } 
 
   public   abstract   class   AbstractS3Response   implements   S3Response   { 
     // ステータスコード 
     public   integer   statusCode { get ;   set ; } 
     // 処理成功フラグ 
     public   boolean   isSuccess { get ;   set ; } 
 
     public   void   setStatusCode ( integer   code )   { 
       this.statusCode   =   code ; 
     } 
 
     // 受け取ったXMLタグの値を取得 
     protected   string   getText ( XmlStreamReader  reader )   { 
       if   ( reader   ==   null )   { 
         return   null ; 
       } 
 
       string   s ; 
       while   ( reader.hasNext ( ) )   { 
         if   ( reader.getEventType ( )   ==   Xmltag.END_ELEMENT )   { 
           break ; 
         }   else   if ( reader.getEventType ( )   ==   XmlTag.CHARACTERS )   { 
           s   =   reader.getText ( ) ; 
           break ; 
         } 
         reader.next ( ) ; 
       } 
       return   s ; 
     } 
 
     // Keyタグをパース 
     protected   S3KeyContents  parseKey ( XmlStreamReader  reader )   { 
       S3KeyContents   c   =   new   S3KeyContents ( ) ; 
 
       if   ( reader   ==   null )   { 
         return   c ; 
       } 
       while   ( reader.hasNext ( ) )   { 
         if   ( reader.getEventType ( )   ==   XmlTag.START_ELEMENT )   { 
           if   ( 'key'   ==   reader.getLocalName ( ) )   { 
             c.key   =   getText ( reader ) ; 
             break ; 
           } 
         } 
         reader.next ( ) ; 
       } 
       return   c ; 
     } 
   } 
 
   /** オブジェクト削除のレスポンス */ 
   public   class   S3MultiDeleteResponse   extends   AbstractS3Response   { 
 
     public   list < string >   deletedKeyList   =   new   list < string > ( ) ; 
     public   list < string >   errorKeyList   =   new   list < string > ( ) ; 
 
     public   void   setResponse ( string   xmlSource )   { 
       system.debug ( 'S3MultiDeleteResponse : delete multiple object response : '   +   xmlSource ) ; 
       try   { 
         XmlStreamReader  reader   =   new   XmlStreamReader ( xmlSource ) ; 
         while ( reader.hasNext ( ) ) { 
           if   ( reader.getEventType ( )   ==   XmlTag.START_ELEMENT )   { 
             if   ( 'Deleted'   ==   reader.getLocalName ( ) )   { 
               S3KeyContents  contents   =   parseKey ( reader ) ; 
               deletedKeyList.add ( contents.key ) ; 
             }   else   if   ( 'Error'   ==   reader.getLocalName ( ) )   { 
               S3KeyContents  contents   =   parseKey ( reader ) ; 
               errorKeyList.add ( contents.key ) ; 
             } 
           } 
           reader.next ( ) ; 
         } 
         isSuccess   =   true ; 
       }   catch   ( Exception   e )   { 
         system.debug ( e ) ; 
         isSuccess   =   false ; 
       } 
     } 
   } 
 
   /** オブジェクト一覧取得のレスポンス */ 
   public   class   S3ListObjectResponse   extends   AbstractS3Response   { 
 
     // 件数オーバーで切り落とされたかどうかフラグ 
     public   boolean   truncated { get ; set ; } 
 
     list < string >   keys   =   new   list < string > ( ) ; 
 
     public   list < string >   getKeys ( )   { 
       return   this.keys ; 
     } 
 
     public   void   setResponse ( string   xmlSource )   { 
       try   { 
         XmlStreamReader  reader   =   new   XmlStreamReader ( xmlSource ) ; 
         while ( reader.hasNext ( ) ) { 
           if   ( reader.getEventType ( )   ==   XmlTag.START_ELEMENT )   { 
             if   ( 'istruncated'   ==   reader.getLocalName ( ) )   { 
               truncated   =   Boolean.valueOF ( getText ( reader ) ) ; 
             }   else   if   ( 'contents'   ==   reader.getLocalName ( ) )   { 
               S3KeyContents  contents   =   parseKey ( reader ) ; 
               keys.add ( contents.key ) ; 
             } 
           } 
           reader.next ( ) ; 
         } 
         isSuccess   =   true ; 
       }   catch   ( Exception   e )   { 
         system.debug ( e ) ; 
         isSuccess   =   false ; 
       } 
     } 
   } 
 
   /** Contentsタグを表す */ 
   public   class   S3KeyContents   { 
     public   string   key { get ;   set ; } 
   } 
 
   /*****************************************************************************/ 
   /** AmazonS3のリクエストを表す ****************************************************/ 
   /*****************************************************************************/ 
   public   interface   S3Request   { 
     string   getXmlSource ( ) ; 
   } 
 
   public   abstract   class   AbstractS3Request   implements   S3Request   { 
   } 
 
   /** 複数オブジェクト削除のリクエスト */ 
   public   class   DeleteMultipleObjectRequest   extends   AbstractS3Request   { 
     public   List < string >   deleteKeyList   { get ;   set ; } 
 
     public   DeleteMultipleObjectRequest ( list < string >   deleteList )   { 
       deleteKeyList   =   deleteList ; 
     } 
 
     public   string   getXmlSource ( )   { 
       string   xmlSource ; 
 
       if   ( deleteKeyList   ==   null   ||   deleteKeyList.isEmpty ( ) )   { 
         return   xmlSource ; 
       } 
 
       // create XML source for AmazonS3 - Delete Multiple Object. http://docs.amazonwebservices.com/AmazonS3/latest/API/multiobjectdeleteapi.html 
       XmlStreamWriter  writer   =   new   XmlStreamWriter ( ) ; 
       writer.writeStartDocument ( 'UTF-8' ,   '1.0' ) ;   // <? xml  version = "1.0"   encoding = "UTF-8" ?> 
       writer.writeStartElement ( null ,   'Delete' ,   null ) ; 
 
       for   ( string   key   :   deleteKeyList )   { 
         // Object 
         writer.writeStartElement ( null ,   'Object' ,   null ) ; 
           writer.writeStartElement ( null ,   'Key' ,   null ) ; 
           writer.writeCharacters ( key ) ; 
           writer.writeEndElement ( ) ; 
         writer.writeEndElement ( ) ; 
       } 
 
       writer.writeEndElement ( ) ; 
       writer.writeEndDocument ( ) ; 
       xmlSource   =   writer.getXmlString ( ) ; 
       writer.close ( ) ; 
      
       return   xmlSource ; 
     } 
   } 
 }