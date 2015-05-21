/*  * * * * * * * * * * * * * * * * * * * *
 *                                        *
 *   external   links                     *
 *                                        *
 *                                        *
 * * * * * * * * * * * * * * * * * * * *  */

// jQuery

$(document).ready(function() {
    $("a").click(function() {
        link_host = this.href.split("/")[2];
        document_host = document.location.href.split("/")[2];

        if (link_host != document_host) {
            window.open(this.href);
            return false;
        }
    });
});

/* * * * * * * * * * * * * * * *
 *
 *  UnobtrusiveFlash
 *
 * * * * * * * * * * * * * * * */

UnobtrusiveFlash.flashOptions['timeout'] = 4000;


/*******************************
 *  the form check:
 *******************************/

function checkform() {
    //var f = document.forms['the_comment_form'].elements;
    var f = document.getElementById('himmel').value;
    var can_submit = true;
    var whitespace = /\S/;
    if (whitespace.test( f )) {
        can_submit = true;
    } else {
        can_submit = false;
    }
    document.getElementById('submit').disabled = !can_submit;
}
