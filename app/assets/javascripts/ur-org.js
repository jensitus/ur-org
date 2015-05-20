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
    var f = document.forms['the_comment_form'].elements;
    var can_submit = true;
    console.log(f[2].value);
    var whitespace = /\S/;
    if (whitespace.test(f[2].value)) {
        can_submit = true;
        console.log(whitespace.test(f[2].value));
    } else {
        can_submit = false;
        console.log(whitespace.test(f[2].value));
    }
    document.getElementById('submit').disabled = !can_submit;
}

//function checkform() {
//    var f = document.forms["the_comment_form"].elements;
//    console.log(f);
//    var cansubmit = true;
//    for (var i = 0; i < f.length; i++) {
//        if (f[i].value.length == 0) {
//            console.log('f[i].value.length:');
//            console.log(f[i].value.length);
//            cansubmit = false;
//        }
//    }
//    document.getElementById("submit").disabled = !cansubmit;
//}

// "value" in f[i] && f[i].value.length == 0