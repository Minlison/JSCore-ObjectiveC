var serializedHighlights = decodeURIComponent(window.location.search.slice(window.location.search.indexOf("=") + 1));
var highlighter;

var favoriteApplier, selNote_temp;

function removeAllRanges() {
    rangy.getSelection().removeAllRanges();
}

function selNote() {

    var sel = highlighter.highlightSelection("note").toString();
    var text = rangy.getSelection().toString();

    selNote_temp = rangy.getSelection().getBookmark($('#mybody')[0]);

    removeAllRanges();
    return JSON.stringify({ text: text, sel: sel });
}

function unNote() {
    if (selNote_temp != null) {
        rangy.getSelection().moveToBookmark(selNote_temp);
        highlighter.unhighlightSelection();
        selNote_temp = null;
        removeAllRanges();
    }
}

function selShare() {
    var sel = highlighter.highlightSelection("share").toString();
    var text = rangy.getSelection().toString();
    removeAllRanges();
    return JSON.stringify({ text: text, sel: sel });

}

function selCopy() {
    var text = rangy.getSelection().toString();
    removeAllRanges();
    return text;

}


function selFavorite() {

    var editableEl = $('#mybody')[0];
    var bookmark = rangy.getSelection().getBookmark(editableEl);
    favoriteApplier.toggleSelection();


    var sel = JSON.stringify(bookmark);

    var text = rangy.getSelection().toString();

    removeAllRanges();

    return JSON.stringify({ text: text, sel: sel });
}

function isAppliedToSelection() {
    return favoriteApplier.isAppliedToSelection();
}

function hidden() {

    $("#mybody").removeClass('mybody').addClass('hiddenMybody');
    $(window).resize();
}

function show() {
    $("#mybody").removeClass('hiddenMybody').addClass('mybody');
    $(window).resize();
}

function loadData(str, serializedHighlights, sel) {
    //alert(str);
    var editableEl = $('#mybody')[0];
    $('#mybody').html(str);
    if (sel && sel != '') {
        $.each(sel, function(i, bookmark) {
            bookmark.rangeBookmarks[0].containerNode = editableEl;
            rangy.getSelection().moveToBookmark(bookmark);
            favoriteApplier.toggleSelection();
        });
    }
    removeAllRanges();
    if (serializedHighlights && serializedHighlights != '') {
        highlighter.deserialize(serializedHighlights);
    }

    $(window).resize();

}

function content_serialize() {
    return highlighter.serialize();
}

function resizeWindow(w, h) {
    return JSON.stringify({ w: w, h: h });
}

$(function() {

    rangy.init();


    highlighter = rangy.createHighlighter();

    highlighter.addClassApplier(rangy.createClassApplier("share", {
        ignoreWhiteSpace: true,
        tagNames: ["span", "a"]
    }));

    highlighter.addClassApplier(rangy.createClassApplier("note", {
        ignoreWhiteSpace: true,
        tagNames: ["span", "a"]
    }));

    /*
     highlighter.addClassApplier(rangy.createClassApplier("favorite", {
     ignoreWhiteSpace: true,
     tagNames: ["span", "a"]
     }));
     */
    favoriteApplier = rangy.createClassApplier("favorite", {
        tagNames: ["span", "a"]
    });

    $(window).scroll(function() {
        removeAllRanges();
    });
    $(document).ready(function() {
        $(window).resize();
    });
    $(window).resize(function() {
        // var w = $(window).innerWidth();
        // var h = $(window).innerHeight();
        // var w = $(document).width();
        // var h = $(document).height()
        var w = $(document.body).width();
        var h = $(document.body).height();

        resizeWindow(w, h);
    });
});
