var callbackMapper = require("presto-ui").helpers.android.callbackMapper;

exports["getPermissionStatus'"] = function(err, success, permission) {
    return function() {
        var callback = callbackMapper.map(function(params) {
            // We get a boolean back
          success(JSON.stringify(params))();
        });
        JBridge.checkPermission(permission, callback);
    };
};

exports["requestPermission'"] = function(cb, permissions, right, left) {
    return function() {
        var callback = callbackMapper.map(function(params) {
            // We get an array of booleans back
            cb(right(JSON.stringify(params)))();
        });
        JBridge.setPermissions(permissions, callback);
    };
};
