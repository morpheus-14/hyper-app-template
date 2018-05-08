var callbackMapper = require('presto-ui').helpers.android.callbackMapper;
window.appId = "in.amazon.pay";
window.__animationId = 0;

exports["showUI'"] = function(sc, screen) {
  return function() {
    var screenJSON = JSON.parse(screen);
    var screenName = screenJSON.tag;
    screenJSON.screen = screenName;
    if(screenName=="InitScreen") {
      screenJSON.screen = "INIT_UI";
    }
    window.__duiShowScreen(sc, screenJSON);
  };
};

exports["startAnim"] = function(animId) {
  Android.startAnim(animId)
}

exports["cancelAnim"] = function(animId) {
  return function(callback) {
    Android.cancelAnim(animId, callback)
  }
}

exports["updateAnim"] = function(viewId) {
  return function(animString) {
    Android.updateAnim(viewId, animString)
  }
}

var callAPIImpl = function(success, err, method, url, body, headersRaw) {
  var successResponse = {};
  var headers = {};
  window["apiName"]= url;
  console.log("URL" , url);
  console.log("METHOD" , method);
  console.log("BODY",body);
  console.log("HEADERS",headersRaw);

  var isSSLPinnedURL = false;
  if (url.indexOf("https://upi.npci.org.in/") != -1) {
    isSSLPinnedURL = true;
  }
 
  for(var i=0;i<headersRaw.length;i++){
    headers[headersRaw[i].field] = headersRaw[i].value;
  }
  var callback = callbackMapper.map(function() {
    if (arguments && arguments.length >= 3) {
      successResponse = {
        status: arguments[0],
        response: JSON.parse(atob(arguments[1]) || "{}"),
        code: parseInt(arguments[2])
      };
      console.log("Response: ");
      console.log(successResponse);
      if(successResponse.status === "failure"){
        console.log("inside failure");
        successResponse.response = {error : true,
                                    errorMessage: "",
                                    userMessage: ""
                                  };
        console.log("Response: ");
        console.log(successResponse);
        success(JSON.stringify(successResponse))();
      }else 
        success(JSON.stringify(successResponse.response))();
    } else {
      success({
        status: "failed",
        response: "{}",
        code: 50
      })();
    }
  });
  JBridge.callAPI(method, url, getEncodedData(body), getEncodedData(JSON.stringify(headers)), isSSLPinnedURL, callback);
};

var getEncodedData = function(data) {
  return  btoa(unescape(encodeURIComponent(data)));
}

var callAPIFn = function(error) {
  return function(success) {
    return function(request) {
      return function() {
        callAPIImpl(success, error, request.method, request.url, request.payload, request.headers);
      };
    };
  };
};

exports["callAPI'"] = callAPIFn;


exports["logAny'"] = function(any) {
  return function () {
    console.log("--->",any);
  }
}

exports["onBackPress'"] = function(cb) {
  return function(left) {
    return function(right) {
     return function() {
        window.onBackPressed = function() {
          console.log("Back pressed");
          window.onBackPressed = null;
          cb()();
        }
     }
    }
  }
};

exports["logMe"] = function(any) {
  return function (argument) {
    console.log(any, ":::::::");
    console.log(argument);
    return argument;
  }
}

exports["startAnimation"] = function(animId) {
  console.log("_________>",animId);

  if(window.keyboardState == false && animId == "keyboardDown"){
     return;
  }

  Android.startAnim(animId);

  if (animId == "keyboardDown"){
    window.keyboardState = false;
  }
}

exports["cancelAnimation"] = function(animId) {
      var callback = callbackMapper.map(function (params) {
          var valueTobeupdated = params;
          var animJson = '{"id":"arcAnim","duration":"1000","props":[{"prop":"sweepAngle","from":"' + valueTobeupdated + '","to":"360"}]}'
          Android.updateAnim (window.shapeId,animJson);
          Android.startAnim (animId);
          
          setTimeout(function() {
            console.log("Executing-->Animation");
            Android.startAnim("centerRound");
            Android.startAnim ("arcAnimFaded");
            setTimeout(function(){
              Android.startAnim ("SuccessFadeIn");
              Android.startAnim ("tickAnim");
              Android.startAnim("delight");
            }, 250)
          },3000)
      });
      console.log("Cancel Animation",animId);
      Android.cancelAnim(animId, callback);
}

exports["getScreenHeight'"] = function() {
  var deviceDetails = JSON.parse(Android.getScreenDimensions());
  if(deviceDetails) {
    return (deviceDetails.height).toString();
  }
} 

exports.getValueFromWindow = function(key) {
  return (typeof window[key] != "undefined") && window[key];
}

exports.setDataInWindow = function(key){
  return function(value){
    window[key] = value;
    return;
  }
}

exports.mkPureType = function(val){
  return val;
}

exports["pxTodp"] = function(value) {
  return Android.dpToPx (value);
}

exports["pxTodpF"] = function(value) {
  return Android.dpToPxF (value);
}

exports._getValueFromWindowWithEff = function(nothing){
    return function(just){
        return function(key){
            return function(){
                return window[key] ? just(window[key]) : nothing ;
            }
        }
    }
}