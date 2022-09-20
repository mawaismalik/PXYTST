var queryParamNames = context.getVariable("request.queryparams.names");
var a = queryParamNames.toArray();

var i = 0;
a.forEach(function(item) {
    
    var paramNames = item.toString();
    var value = escapeForXML(context.getVariable('message.queryparam.'+paramNames));
    context.setVariable(paramNames, value);

});



function escapeForXML(value) {
    try {
        return value
         .replace(/&/g, "&amp;")
         .replace(/</g, "&lt;")
         .replace(/>/g, "&gt;")
         .replace(/"/g, "&quot;")
         .replace(/'/g, '&apos;');
    }
    catch (e) {
        return e;
    }
}