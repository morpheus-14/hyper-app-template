var R = require('ramda');
exports["toKeyVals'"] = function(obj) {
	if(typeof obj === "object") {
		var arr = [];
		Object.keys(obj).forEach(function(key) {
			var val;
			if(obj[key] == null || obj[key] == undefined) return;
			if(typeof obj[key] === "string") {
				val = obj[key];
			} else {
				val = JSON.stringify(obj[key]);
			}

			arr.push({"key": key, "val": val});
		});
		return arr;
	} else {
		return [];
	}
}

exports["getErrorScreenType'"] = function(errorCode){
	var apiName = window ? (window["apiName"] ? window["apiName"] : "") : ""; 
	var errorTypePath = R.lensPath([apiName,errorCode])
	var errorJson = R.view(errorTypePath,strConfig);
	if(R.keys(errorJson)[0] && R.values(errorJson)[0])
		return {tag: R.keys(errorJson)[0],contents: JSON.stringify(R.values(errorJson)[0])};
	else 
		return {tag: "SNACKBAR",contents:"Error in JSON Parsing"}		
}


const strConfig =  {  
   "/api/v2/loginTokens":{  
      "JP03":{  
      	"POPUP" :{
	         "title":"Jailbroken Device",
	         "body":"Your security may be compromised since your device is jailbroken so we can not let you proceed. Kindly use a non jailbroken device to access BHIM.",
	         "button1":"Exit"
	     }
      },
      "JP04":{
      	"POPUP": {
	         "title":"Jailbroken Device",
	         "body":"Your security may be compromised since your device is jailbroken. Proceed at your own risk.",
	         "button1":"Proceed",
	         "button2":"Exit"
	     }
      },
      "JP32":{ "SNACKBAR" : "Wrong Passcode"},
      "JP31":{  
         "POPUP":{  
            "title":"Limit exceeded",
            "body":"You have exceeded maximum number of tries to login into the app. Please try again after {X} minutes.",
            "button1":"Cancel"
         }
      }
   }
}
