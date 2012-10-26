.pragma library

function fnGetItemRoot(item) {

    var parent = item.parent
    while (parent.parent) parent = parent.parent
    return parent;
}

function fnIsValidDate(date) {
    return ( Object.prototype.toString.call(date) === "[object Date]" && !isNaN(date.getTime()) );
}
