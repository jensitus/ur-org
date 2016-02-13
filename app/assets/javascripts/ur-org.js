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

/*  * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 *
 *        the photo upload and micropost_form stuff
 *
*/



var counter = (function(){
    var private_counter = 0;
    function changeBy(val) {
        private_counter += val;
    }
    return {
        increment: function() {
            changeBy(1);
        },
        value: function() {
            return private_counter
        }
    }
})();

function theFileInput() {
    var preview_count = preview_c();
//            console.log('preview_c: ' + preview_c());
    if (preview_count < 5) {
//                console.log('too_much: ' + (document.getElementById('too_much') != null));
        if (document.getElementById('too_much') != null) {
            document.getElementById('too_much').parentNode.removeChild(document.getElementById('too_much'));
            var extra = document.createElement('span');
            extra.setAttribute('id', 'etwas');
            document.getElementById('the_etwas_box').appendChild(extra);
            //console.log(document.getElementsByClassName('the_etwas_box'));
            document.getElementById('add_images').style.display = '';
        }

        var block = blocks_count();

        if (block > -1) {
            // do nothing, everything is alright
        } else {
            counter.increment();
            var x = document.createElement('input');
            x.setAttribute('type', 'file');
            x.setAttribute('name', 'photos[picture][]');
            x.setAttribute('onchange', 'disappear()');
            x.setAttribute('id', 'files-' + counter.value());
            x.style.display = 'block';
            x.setAttribute('accept', 'image/jpeg,image/gif,image/png');
            x.addEventListener('change', handleFileSelect, true);
            document.getElementById('next_image').appendChild(x);
        }

        var a = document.getElementById('too_much');
//                console.log('a: ' + a);
        if (a != null) {
            //a.style.display = 'none';
            var etwas = document.createElement('span');
            etwas.setAttribute('id', 'etwas');
            a.parentNode.replaceChild(etwas, a);
        }

    } else {
        var y = document.createElement('span');
        var z = document.getElementById('etwas');   //('files-' + counter.value());
        document.getElementById('add_images').style.display = 'none';
        //console.log('z: ' + z.id);
        y.setAttribute('id', 'too_much');
        y.setAttribute('class', 'alert alert-danger');
        y.innerHTML = "Sorry, but for now that's enough";
        z.parentNode.replaceChild(y, z);
    }
}

function blocks_count() {
    var blocks = new Array;
    var elements = document.getElementById('next_image').children;

    for ( var i = 0; i < elements.length; i++) {
//                console.log('e: ' + elements[i].tagName);
        if (elements[i].tagName == 'INPUT') {
            var e = elements[i],
                style = window.getComputedStyle(e),
                display = style.getPropertyValue('display');
            console.log('display: ' + display);
            blocks.push(display);
        }
    }
//            console.log('blocks_count, blocks: ' + blocks);
    return blocks.indexOf('block');
}

function handleFileSelect(evt) {

    var files = evt.target.files;
    var id_counter = counter.value(); // evt.target.id_counter;
//            console.log('handleFileSelect, id_counter: ' + id_counter);

    for (var a = 0, f; f = files[a]; a++) {
        if (!f.type.match('image.*')) {
            continue;
        }
        var reader = new FileReader();
        reader.onload = (function(theFile) {
            return function(e) {

                var image_size;
                if (theFile.size > 1000) {
                    var s = theFile.size / 1024;
                    if (s > 1000) {
                        image_size = (s / 1024).toFixed(2) + ' MB';
                    } else {
                        image_size = s.toFixed(2) + ' kb';
                    }
                } else {
                    image_size = theFile.size.toString() + ' bytes';
                }

                var vorschau = document.createElement('img');
                vorschau.className = 'thumb';
                vorschau.src = e.target.result;
                vorschau.title = theFile.name;

                //var MAX_WIDTH = 800;
                //var MAS_Height = 600;
                //console.log('width: ');
                //console.log(vorschau.width);

//                        console.log('image.size: ' + image_size);
//                        console.log('vorschau.title: ' + vorschau.title);
                var size_title = document.createElement('span');
                size_title.innerHTML = vorschau.title + '    ' + image_size;
                size_title.style.margin = '15px';
                vorschau.id = 'preview_image-' + id_counter;
                vorschau.addEventListener('load', theFileInput, false);
                var the_vorschau_span =  document.createElement('div'); //create_vorschau_span(id_counter);
                var delete_x = delete_the_image_button(id_counter);

                var preview_table = document.getElementById('preview_table');
                var row = preview_table.insertRow(0);
                row.setAttribute('id', 'preview_row-' + id_counter);
                var cell_vorschau = row.insertCell(0);
                var cell_title = row.insertCell(1);
                var cell_size = row.insertCell(2);
                var cell_del_button = row.insertCell(3);

                var delete_the_row = document.getElementById('preview_row-' + id_counter);
                delete_x.addEventListener(
                    'click',
                    function() {
                        delete_the_row.parentNode.removeChild(delete_the_row)
                    },
                    true
                );
                delete_x.addEventListener(
                    'click', theFileInput, false
                );
                cell_vorschau.appendChild(vorschau);
                cell_title.innerHTML = vorschau.title;
                cell_size.innerHTML = image_size;
                cell_del_button.appendChild(delete_x);


            }
        })(f);
        reader.readAsDataURL(f);
    }
}

function delete_the_image_button(id_count) {
    var id_counter = id_count;
    //console.log('id_counter_delete_func ' + id_counter);
    var image_delete_button = document.createElement('span');

    image_delete_button.setAttribute('id', 'image_delete_button_' + id_counter);
    // var the_list_for_deleting_the_button = document.getElementById('list');
    var del_this = document.getElementById('files-' + id_counter);
    //console.log('del_this: ' + del_this);
    image_delete_button.setAttribute('class', 'btn btn-xs btn-warning');
    image_delete_button.innerHTML = 'delete';
    image_delete_button.addEventListener(
        'click',
        function(){
            del_this.parentNode.removeChild(del_this);
        });
    return image_delete_button;
}

function preview_c() {
//            console.log('previewlist: ' + document.getElementById('preview_tbody').childElementCount);
    return document.getElementById('preview_tbody').childElementCount;
}

//window.onload = theFileInput();

function disappear() {
    document.getElementById('files-' + counter.value()).style.display = 'none';
}

//document.addEventListener('DOMContentLoaded', init, false);


function init() {
    var first_input_tag = document.querySelector('#files-' + counter.value());
    first_input_tag.addEventListener('change', handleFileSelect, true);
    //first_input_tag.addEventListener('change', theFileInput, false)
}

$('#micropost_picture').bind('change', function() {
    size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
        alert('it must be smaller than 5MB');
    }
});

$('#content_field').on('keyup', function(){
    length = $(this).val().length;
    $('#content_count').html(length);
});

$(document).one('focus.textarea', '.expandable', function() {
    var savedValue = this.value;
    this.value = '';
    this.baseScrollHeight = this.scrollHeight;
    this.value = savedValue;
}).on('input.textarea', '.expandable', function() {
    var minRows = this.getAttribute('data-min-rows')| 0, rows;
    this.rows = minRows;
    console.log(this.scrollHeight, this.baseScrollHeight);
    rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 15);
    this.rows = minRows + rows;
});

function check_the_post_form() {
    //var f = document.forms["the_post_form"].elements;
    var f = document.getElementById('content_field').value;
    var cansubmit = true;
    var non_whitespace = /\S/;
    if (non_whitespace.test( f )) {
        cansubmit = true;
    } else {
        cansubmit = false;
    }
    document.getElementById("submit").disabled = !cansubmit;
}

//$($document).ready(function() {
//    $('#only_photo_upload').attr('disabled', true);
//    $('input:file').change(
//        function() {
//            if ($(this).val()) {
//                $('#only_photo_upload').removeAttr('disabled');
//            }  else {
//                $('#only_photo_upload').attr('disabled', true)
//            }
//        }
//    )
//});

//window.onload = check_the_post_form();

$(document).ready(function() {
    $("#content_field").click(function () {
        $("#collapseExample").collapse('show');
    });
    $('#leave').click(function () {
        $('#collapseExample').collapse('hide');
    });
});

/* * * * * * * * * * * * * * * *
 *  the register multiplication
 * * * * * * * * * * * * * * * */

function register_multiply() {
    var v = document.getElementById('register_multiplication').value;
    var can_register = false;
    //document.getElementById('register_submit').disabled = !can_register;
    //console.log('v');
    //var x = Math.floor((Math.random() * 10 ) + 1);
    //var y = Math.floor((Math.random() * 10 ) + 1);
    //console.log(x);
    //console.log(y);
    //var res = x * y;
    //console.log(res);
    //console.log(document.getElementById('register_submit').disabled);
    //document.getElementById('multiply').innerHTML = x + ' times ' + y;
    //get_result(res);
}

function get_result(res) {
    var get_the_result = res;
    //console.log('get_the_result: ');
    //console.log(get_the_result);
    return get_the_result;
}

function register_multiply_result() {
    var result = document.getElementById('register_multiplication').value;
    //console.log(result);
    //var submit_button = document.getElementById('register_submit').disabled;
    //console.log(submit_button);
    if (result == '42') {
        document.getElementById('register_submit').disabled = false;
    } else {
        document.getElementById('register_submit').disabled = true;
    }
    //var the_result = get_result();
    //console.log('the_result ********');
    //console.log(the_result);
}
