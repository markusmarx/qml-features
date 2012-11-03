.pragma library

function fnGetItemRoot(item) {

    var parent = item.parent
    while (parent.parent) parent = parent.parent
    return parent;
}

function fnIsValidDate(date) {
    return ( Object.prototype.toString.call(date) === "[object Date]" && !isNaN(date.getTime()) );
}

function fnIsValidTime(value) {
   var colonCount = 0;
   var hasMeridian = false;
   for (var i=0; i<value.length; i++) {
      var ch = value.substring(i, i+1);
      if ( (ch < '0') || (ch > '9') ) {
         if ( (ch != ':') && (ch != ' ') && (ch != 'a') && (ch != 'A') && (ch != 'p') && (ch != 'P') && (ch != 'm') && (ch != 'M')) {
            return false;
         }
      }
      if (ch == ':') { colonCount++; }
      if ( (ch == 'p') || (ch == 'P') || (ch == 'a') || (ch == 'A') ) { hasMeridian = true; }
   }
   if ( (colonCount < 1) || (colonCount > 2) ) { return false; }
   var hh = value.substring(0, value.indexOf(":"));
   if ( (parseFloat(hh) < 0) || (parseFloat(hh) > 23) ) { return false; }
   if (hasMeridian) {
      if ( (parseFloat(hh) < 1) || (parseFloat(hh) > 12) ) { return false; }
   }
   if (colonCount == 2) {
      var mm = value.substring(value.indexOf(":")+1, value.lastIndexOf(":"));
   } else {
      var mm = value.substring(value.indexOf(":")+1, value.length);
   }
   if ( (parseFloat(mm) < 0) || (parseFloat(mm) > 59) ) { return false; }
   if (colonCount == 2) {
      var ss = value.substring(value.lastIndexOf(":")+1, value.length);
   } else {
      var ss = "00";
   }
   if ( (parseFloat(ss) < 0) || (parseFloat(ss) > 59) ) { return false; }
   return true;
}
