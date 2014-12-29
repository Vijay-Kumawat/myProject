public with sharing class SelectOptionClass {
    
    public String state {get; set;}
    public String country {get; set;}
    public String item {get; set;}
    
    public SelectOptionClass() {
        
        state = '';
        country = '';
        item = '';
    }
    
    public List<SelectOption> getItems() {
    
        //Instatiate select option
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('1','1'));
        options.add(new SelectOption('2','2'));
        options.add(new SelectOption('3','3'));
        
        return options;
    }


    /** 
     *    @description    :    Method to get option in Picklist of Country. 
     *                          
     *    @args           :    
     *                      
     *    @return         :     List<SelectOption>        
     *
    **/
    public List<SelectOption> getCountries() {
       
        //Instatiate select option
        List<SelectOption> options = new List<SelectOption>();
        
        System.debug('####' + country);
     
        options.add(new SelectOption('None','None'));
        options.add(new SelectOption('United States','United States'));
        options.add(new SelectOption('Argentina','Argentina'));
        options.add(new SelectOption('Australia','Australia'));
        options.add(new SelectOption('Austria','Austria'));
        options.add(new SelectOption('Belgium','Belgium'));
        options.add(new SelectOption('Bermuda','Bermuda'));
        options.add(new SelectOption('Brazil','Brazil'));
        options.add(new SelectOption('Canada','Canada'));
        options.add(new SelectOption('Chile','Chile'));
        options.add(new SelectOption('China','China'));
        options.add(new SelectOption('Colombia','Colombia'));
        options.add(new SelectOption('Denmark','Denmark'));
        options.add(new SelectOption('Finland','Finland'));
        options.add(new SelectOption('France','France'));
        options.add(new SelectOption('Germany','Germany'));
        options.add(new SelectOption('Greece','Greece'));
        options.add(new SelectOption('Hong Kong','Hong Kong'));
        options.add(new SelectOption('Iceland','Iceland'));
        options.add(new SelectOption('India','India'));
        options.add(new SelectOption('Ireland','Ireland'));
        options.add(new SelectOption('Israel','Israel'));
        options.add(new SelectOption('Italy','Italy'));
        options.add(new SelectOption('Japan','Japan'));
        options.add(new SelectOption('Kenya','Kenya'));
        options.add(new SelectOption('Lebanon','Lebanon'));
        options.add(new SelectOption('Malaysia','Malaysia'));
        options.add(new SelectOption('Mexico','Mexico'));
        options.add(new SelectOption('Netherlands','Netherlands'));
        options.add(new SelectOption('New Zealand','New Zealand'));
        options.add(new SelectOption('Norway','Norway'));
        options.add(new SelectOption('Pakistan','Pakistan'));
        options.add(new SelectOption('Philippines','Philippines'));
        options.add(new SelectOption('Portugal','Portugal'));
        options.add(new SelectOption('Qatar','Qatar'));
        options.add(new SelectOption('Republic of Panama','Republic of Panama'));
        options.add(new SelectOption('Romania','Romania'));
        options.add(new SelectOption('Russia','Russia'));
        options.add(new SelectOption('Saudi Arabia','Saudi Arabia'));
        options.add(new SelectOption('Singapore','Singapore'));
        options.add(new SelectOption('South Africa','South Africa'));
        options.add(new SelectOption('Spain','Spain'));
        options.add(new SelectOption('Sweden','Sweden'));
        options.add(new SelectOption('Switzerland','Switzerland'));
        options.add(new SelectOption('Taiwan','Taiwan'));
         options.add(new SelectOption('Thailand','Thailand'));
        options.add(new SelectOption('Turkey','Turkey'));
        options.add(new SelectOption('United Arab Emirates','United Arab Emirates'));
        options.add(new SelectOption('United Kingdom','United Kingdom'));
        options.add(new SelectOption('Afghanistan','Afghanistan'));
        options.add(new SelectOption('Aland Islands','Aland Islands'));
        options.add(new SelectOption('Albania','Albania'));
        options.add(new SelectOption('Algeria','Algeria'));
        options.add(new SelectOption('American Samoa','American Samoa'));
        options.add(new SelectOption('Andorra','Andorra'));
        options.add(new SelectOption('Angola','Angola'));
        options.add(new SelectOption('Anguilla','Anguilla'));
        options.add(new SelectOption('Antartica','Antartica'));
        options.add(new SelectOption('Antigua and Barbuda','Antigua and Barbuda'));
        options.add(new SelectOption('Armenia','Armenia'));
        options.add(new SelectOption('Aruba','Aruba'));
        options.add(new SelectOption('Azerbaijan','Azerbaijan'));
        options.add(new SelectOption('Bahamas','Bahamas'));
        options.add(new SelectOption('Bahrain','Bahrain'));
        options.add(new SelectOption('Bangladesh','Bangladesh'));
        options.add(new SelectOption('Barbados','Barbados'));
        options.add(new SelectOption('Belarus','Belarus'));
        options.add(new SelectOption('Belize','Belize'));
        options.add(new SelectOption('Benin','Benin'));
        options.add(new SelectOption('Bhutan','Bhutan'));
        options.add(new SelectOption('Bolivia','Bolivia'));
        options.add(new SelectOption('Bosnia and Herzegovina','Bosnia and Herzegovina'));
        options.add(new SelectOption('Botswana','Botswana'));
        options.add(new SelectOption('Bouvet Island','Bouvet Island'));
        options.add(new SelectOption('British Indian Ocean Territory','British Indian Ocean Territory'));
        options.add(new SelectOption('Brunei Darussalam','Brunei Darussalam'));
        options.add(new SelectOption('Bulgaria','Bulgaria'));
        options.add(new SelectOption('Burkina Faso','Burkina Faso'));
        options.add(new SelectOption('Burundi','Burundi'));
        options.add(new SelectOption('Cambodia','Cambodia'));
        options.add(new SelectOption('Cameroon','Cameroon'));
        options.add(new SelectOption('Cape Verde','Cape Verde'));
        options.add(new SelectOption('Cayman Islands','Cayman Islands'));
        options.add(new SelectOption('Central African Republic','Central African Republic'));
        options.add(new SelectOption('Chad','Chad'));
        options.add(new SelectOption('Christmas Island','Christmas Island'));
        options.add(new SelectOption('Cocos Islands','Cocos Islands'));
        options.add(new SelectOption('Comoros','Comoros'));
        options.add(new SelectOption('Congo','Congo'));
        options.add(new SelectOption('Congo, The Democratic Republic of','Congo, The Democratic Republic of'));
        options.add(new SelectOption('Cook Islands','Cook Islands'));
        options.add(new SelectOption('Costa Rica','Costa Rica'));
        options.add(new SelectOption('Cote D\'ivoire','Cote D\'ivoire'));
        options.add(new SelectOption('Croatia','Croatia'));
        options.add(new SelectOption('Cuba','Cuba'));
        options.add(new SelectOption('Cyprus','Cyprus'));
        options.add(new SelectOption('Djibouti','Djibouti'));
        options.add(new SelectOption('Dominica','Dominica'));
        options.add(new SelectOption('Dominican Republic','Dominican Republic'));
        options.add(new SelectOption('Ecuador','Ecuador'));
        options.add(new SelectOption('Egypt','Egypt'));
        options.add(new SelectOption('El Salvador','El Salvador'));
        options.add(new SelectOption('Equatorial Guinea','Equatorial Guinea'));
        options.add(new SelectOption('Eritrea','Eritrea'));
        options.add(new SelectOption('Estonia','Estonia'));
        options.add(new SelectOption('Ethiopia','Ethiopia'));
        options.add(new SelectOption('Falkland Islands','Falkland Islands'));
        options.add(new SelectOption('Faroe Islands','Faroe Islands'));
        options.add(new SelectOption('Fiji','Fiji'));
        options.add(new SelectOption('French Guiana','French Guiana'));
        options.add(new SelectOption('French Polynesia','French Polynesia'));
        options.add(new SelectOption('French Southern Territories','French Southern Territories'));
        options.add(new SelectOption('Gabon','Gabon'));
        options.add(new SelectOption('Gambia','Gambia'));
        options.add(new SelectOption('Georgia','Georgia'));
        options.add(new SelectOption('Ghana','Ghana'));
        options.add(new SelectOption('Gibraltar','Gibraltar'));
        options.add(new SelectOption('Greenland','Greenland'));
        options.add(new SelectOption('Grenada','Grenada'));
        options.add(new SelectOption('Guadeloupe','Guadeloupe'));
        options.add(new SelectOption('Guam','Guam'));
        options.add(new SelectOption('Guatemala','Guatemala'));
        options.add(new SelectOption('Guernsey','Guernsey'));
        options.add(new SelectOption('Guineaof ','Guinea'));
        options.add(new SelectOption('Guinea-Bissau','Guinea-Bissau'));
        options.add(new SelectOption('Guyana','Guyana'));
        options.add(new SelectOption('Haiti','Haiti'));
        options.add(new SelectOption('Heard Island and McDonald Island','Heard Island and McDonald Island'));
        options.add(new SelectOption('Holy See (Vatican City State)','Holy See (Vatican City State)'));
        options.add(new SelectOption('Honduras','Honduras'));
        options.add(new SelectOption('Hungary','Hungary'));
        options.add(new SelectOption('Indonesia','Indonesia'));
        options.add(new SelectOption('Iran','Iran'));
        options.add(new SelectOption('Iraq','Iraq'));
        options.add(new SelectOption('Isle of Man','Isle of Man'));
        options.add(new SelectOption('Jamaica','Jamaica'));
        options.add(new SelectOption('Jersey','Jersey'));
        options.add(new SelectOption('Jordan','Jordan'));
        options.add(new SelectOption('Kazakhstan','Kazakhstan'));
        options.add(new SelectOption('Kiribati','Kiribati'));
        options.add(new SelectOption('Korea, Republic of Korea','Korea, Republic of Korea'));
        options.add(new SelectOption('Korea, Democratic People\'s Republic of','Korea, Democratic People\'s Republic of'));
        options.add(new SelectOption('Kuwait','Kuwait'));
        options.add(new SelectOption('Kyrgyzstan','Kyrgyzstan'));
        options.add(new SelectOption('Lao People\'s Democratic Republic','Lao People\'s Democratic Republic'));
        options.add(new SelectOption('Latvia','Latvia'));
        options.add(new SelectOption('Lesotho','Antigua and Barbuda'));
        options.add(new SelectOption('Liberia','Liberia'));
        options.add(new SelectOption('Libyan Arab Jamahiriya','Libyan Arab Jamahiriya'));
        options.add(new SelectOption('Liechtenstein','Liechtenstein'));
        options.add(new SelectOption('Lithuania','Lithuania'));
        options.add(new SelectOption('Luxembourg','Luxembourg'));
        options.add(new SelectOption('Macao','Macao'));
        options.add(new SelectOption('Macedonia','Macedonia'));
        options.add(new SelectOption('Madagascar','Madagascar'));
        options.add(new SelectOption('Malawi','Malawi'));
        options.add(new SelectOption('Maldives','Maldives'));
        options.add(new SelectOption('Mali','Mali'));
        options.add(new SelectOption('Malta','Malta'));
        options.add(new SelectOption('Marshall Islands','Marshall Islands'));
        options.add(new SelectOption('Martinique','Martinique'));
        options.add(new SelectOption('Mauritania','Mauritania'));
        options.add(new SelectOption('Mauritius','Mauritius'));
        options.add(new SelectOption('Mayotte','Mayotte'));
        options.add(new SelectOption('Micronesia','Micronesia'));
        options.add(new SelectOption('Moldova','Moldova'));
        options.add(new SelectOption('Monaco','Monaco'));
        options.add(new SelectOption('Mongolia','Mongolia'));
        options.add(new SelectOption('Montenegro','Montenegro'));
        options.add(new SelectOption('Montserrat','Montserrat'));
        options.add(new SelectOption('Morocco','Morocco'));
        options.add(new SelectOption('Mozambique','Mozambique'));
        options.add(new SelectOption('Myanmar','Myanmar'));
        options.add(new SelectOption('Namibia','Namibia'));
        options.add(new SelectOption('Nauru','Nauru'));
        options.add(new SelectOption('Nepal','Nepal'));
        options.add(new SelectOption('New Caledonia','New Caledonia'));
        options.add(new SelectOption('Nicaragua','Nicaragua'));
        options.add(new SelectOption('Niger','Niger'));
        options.add(new SelectOption('Nigeria','Nigeria'));
        options.add(new SelectOption('Niue','Niue'));
        options.add(new SelectOption('Norfolk Island','Norfolk Island'));
        options.add(new SelectOption('Northern Mariana Islands','Northern Mariana Islands'));
        options.add(new SelectOption('Oman','Oman'));
        options.add(new SelectOption('Palau','Palau'));
        options.add(new SelectOption('Palestinian Territory, Occupied','Palestinian Territory, Occupied'));
        options.add(new SelectOption('Panama','Panama'));
        options.add(new SelectOption('Papua New Guinea','Papua New Guinea'));
        options.add(new SelectOption('Paraguay','Paraguay'));
        options.add(new SelectOption('Peru','Peru'));
        options.add(new SelectOption('Pitcairn','Pitcairn'));
        options.add(new SelectOption('Poland','Poland'));
        options.add(new SelectOption('Puerto Rico','Puerto Rico'));
        options.add(new SelectOption('Reunion','Reunion'));
        options.add(new SelectOption('Russian Federation','Russian Federation'));
        options.add(new SelectOption('Rwanda','Rwanda'));
        options.add(new SelectOption('Saint Barthélemy','Saint Barthélemy'));
        options.add(new SelectOption('Saint Helena','Saint Helena'));
        options.add(new SelectOption('Saint Kitt and Nevis','Saint Kitt and Nevis'));
        options.add(new SelectOption('Saint Lucia','Saint Lucia'));
        options.add(new SelectOption('Saint Martin','Saint Martin'));
        options.add(new SelectOption('Saint Pierre and Miquelon','Saint Pierre and Miquelon'));
        options.add(new SelectOption('Saint Vincent and the Grenadines','Saint Vincent and the Grenadines'));
        options.add(new SelectOption('Samoa','Samoa'));
        options.add(new SelectOption('San Marino','San Marino'));
        options.add(new SelectOption('Sao Tome and PrincipeSenegal','Sao Tome and PrincipeSenegal'));
        options.add(new SelectOption('Serbia','Serbia'));
        options.add(new SelectOption('Seychelles','Seychelles'));
        options.add(new SelectOption('Sierra Leone','Sierra Leone'));
        options.add(new SelectOption('Slovakia','Slovakia'));
        options.add(new SelectOption('Slovenia','Slovenia'));
        options.add(new SelectOption('Solomon Islands','Solomon Islands'));
        options.add(new SelectOption('Somalia','Somalia'));
        options.add(new SelectOption('South Georgia and South Sandwich','South Georgia and South Sandwich'));
        options.add(new SelectOption('Sri Lanka','Sri Lanka'));
        options.add(new SelectOption('Sudan','Sudan'));
        options.add(new SelectOption('Suriname','Suriname'));
        options.add(new SelectOption('Svalbard and Jan Mayen','Svalbard and Jan Mayen'));
        options.add(new SelectOption('Swaziland','Swaziland'));
        options.add(new SelectOption('Syrian Arab Republic','Syrian Arab Republic'));
        options.add(new SelectOption('Tanzania','Tanzania'));
        options.add(new SelectOption('Tajikistan','Tajikistan'));
        options.add(new SelectOption('Timor-Leste','Timor-Leste'));
        options.add(new SelectOption('Togo','Togo'));
        options.add(new SelectOption('Tokelau','Tokelau'));
        options.add(new SelectOption('Tonga','Tonga'));
        options.add(new SelectOption('Trinidad and Tobago','Trinidad and Tobago'));
        options.add(new SelectOption('Tunisia','Tunisia'));
        options.add(new SelectOption('Turkmenistan','Turkmenistan'));
        options.add(new SelectOption('Turks and Caicos','Turks and Caicos'));
        options.add(new SelectOption('Tuvalu','Tuvalu'));
        options.add(new SelectOption('Uganda','Uganda'));
        options.add(new SelectOption('Ukraine','Ukraine'));
        options.add(new SelectOption('Uruguay','Uruguay'));
        options.add(new SelectOption('Uzbekistan','Uzbekistan'));
        options.add(new SelectOption('Vanuatu','Vanuatu'));
        options.add(new SelectOption('Venezuela','Venezuela'));
        options.add(new SelectOption('Viet Nam','Viet Nam'));
        options.add(new SelectOption('Virgin Islands, British','Virgin Islands, British'));
        options.add(new SelectOption('Virgin Islands, US','Virgin Islands, US'));
        options.add(new SelectOption('Wallis and Futuna','Wallis and Futuna'));
        options.add(new SelectOption('Western Sahara','Western Sahara'));
        options.add(new SelectOption('Yemen','Yemen'));
        options.add(new SelectOption('Zambia','Zambia'));
        options.add(new SelectOption('Zimbabwe','Zimbabwe'));
        options.add(new SelectOption('Other','Other'));
            
        //Return list of Options
        return options;
    }
    
    /** 
     *    @description    :    Method to get option in Picklist of State  
     *                          
     *    @args           :    
     *                      
     *    @return         :     List<SelectOption>        
     *
    **/
     public List<SelectOption> getStates() {
                          
         //Instatiate select option
         List<SelectOption> options = new List<SelectOption>();
         
            if(country == 'United States') {
         
            options.add(new SelectOption('--None--','--None--'));
             options.add(new SelectOption('AK','AK'));
             options.add(new SelectOption('AL','AL'));
             options.add(new SelectOption('AR','AR'));
             options.add(new SelectOption('AS','AS'));
             options.add(new SelectOption('AZ','AZ'));
             options.add(new SelectOption('CA','CA'));
             options.add(new SelectOption('CO','CO'));
             options.add(new SelectOption('CT','CT'));
             options.add(new SelectOption('DC','DC'));
             options.add(new SelectOption('DE','DE'));
             options.add(new SelectOption('FL','FL'));
             options.add(new SelectOption('GA','GA'));
             options.add(new SelectOption('HI','HI'));
             options.add(new SelectOption('IA','IA'));
             options.add(new SelectOption('ID','ID'));
             options.add(new SelectOption('IL','IL'));
             options.add(new SelectOption('IN','IN'));
             options.add(new SelectOption('KS','KS'));
             options.add(new SelectOption('KY','KY'));
             options.add(new SelectOption('LA','LA'));
             options.add(new SelectOption('MA','MA'));
             options.add(new SelectOption('MD','MD'));
             options.add(new SelectOption('ME','ME'));
             options.add(new SelectOption('MI','MI'));
             options.add(new SelectOption('MN','MN'));
             options.add(new SelectOption('MO','MO'));
             options.add(new SelectOption('MS','MS'));
             options.add(new SelectOption('MT','MT'));
             options.add(new SelectOption('NC','NC'));
             options.add(new SelectOption('ND','ND'));
             options.add(new SelectOption('NE','NE'));
             options.add(new SelectOption('NH','NH'));
             options.add(new SelectOption('NJ','NJ'));
             options.add(new SelectOption('NM','NM'));
             options.add(new SelectOption('NV','NV'));
             options.add(new SelectOption('NY','NY'));
             options.add(new SelectOption('OH','OH'));
             options.add(new SelectOption('OK','OK'));
             options.add(new SelectOption('OR','OR'));
             options.add(new SelectOption('PA','PA'));
             options.add(new SelectOption('PR','PR'));
             options.add(new SelectOption('RI','RI'));
             options.add(new SelectOption('SC','SC'));
             options.add(new SelectOption('SD','SD'));
             options.add(new SelectOption('TN','TN'));
             options.add(new SelectOption('TX','TX'));
             options.add(new SelectOption('UT','UT'));
             options.add(new SelectOption('VA','VA'));
             options.add(new SelectOption('VT','VT'));
             options.add(new SelectOption('WA','WA'));
             options.add(new SelectOption('WI','WI'));
             options.add(new SelectOption('WV','WY'));
             options.add(new SelectOption('FM','FM'));
             options.add(new SelectOption('GU','GU'));
             options.add(new SelectOption('MP','MP'));
             options.add(new SelectOption('PW','PW'));
             options.add(new SelectOption('VI','VI'));
         
            }
            else
                options.add(new SelectOption('',''));
                
        //Return list of Options
        return options;
     }    
     
     public PageReference Dummy() {
        return null;
    }
}