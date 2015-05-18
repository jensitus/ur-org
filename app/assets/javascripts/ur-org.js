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
    var f = document.forms["the_comment_form"].elements;
    var cansubmit = true;
    for (var i = 0; i < f.length; i++) {
        if ("value" in f[i] && f[i].value.length == 0) {
            cansubmit = false;
        }
    }
    document.getElementById("submit").disabled = !cansubmit;
}
