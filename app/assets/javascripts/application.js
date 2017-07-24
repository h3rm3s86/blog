// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require twitter/bootstrap
//= require_tree .

$(document).on('turbolinks:load', function(){
    $.get("v2/articles/index", function(data, status){
        console.log("Data: " + data + "\nStatus: " + status);

        var table = document.createElement('table');
        table.cellpadding = 0;
        table.cellspacing = 0;
        table.border = 1;
        $("#tab").append(table);

        var text = undefined;
        var edit_row = undefined;
        var delete_row = undefined;
        var linkText = undefined;
        
        for (var i = 0; i < data.length; i++){
            var row = document.createElement('tr');
            var column1 = document.createElement('td');
            var column2 = document.createElement('td');
            var column3 = document.createElement('td');
            var column4 = document.createElement('td');
            var column5 = document.createElement('td');

            text = document.createTextNode(data[i].title);
            row.appendChild(column1);
            column1.appendChild(text);

            text = document.createTextNode(data[i].text);
            column2.appendChild(text);
            row.appendChild(column2);

            text = document.createElement('a');
            text.setAttribute("href", "http://localhost:3000/articles/" + data[i].id);
            text.innerHTML = "Show";
            column3.appendChild(text);
            row.appendChild(column3);

            edit_row = document.createElement('a');
            edit_row.id = "edit" + data[i].id;
            edit_row.innerHTML = "Edit";
            column4.appendChild(edit_row);
            row.appendChild(column4);

            delete_row = document.createElement('a');
            delete_row.id = "del" + data[i].id;
            delete_row.innerHTML = "Delete";
            column5.appendChild(delete_row);
            row.appendChild(column5);

            table.appendChild(row);

            $("#"+delete_row.id).click(function(){
                                            var id = $(this)[0].id;
                                            id = id.substring(3);
				                            $.ajax({type: "POST",
                                                    url: "http://localhost:3000/articles/" + id,
                                                    method: 'DELETE',
                                                    success: function(data) {
                                                                //this.parent('tr').remove();
                                                                $('td').parent().parent().remove();
                                                                //location.reload();
                                                            }
                                            });
                                    });

            $("#"+edit_row.id).click(function(){
                                        var id = $(this)[0].id;
                                        id = id.substring(4);
                                        console.log(id);
                                        var string = '<input type="text" id="text" value="'+$(this).closest('tr').find('td').eq(1).html()+'">';
                                        $(this).closest('tr').find('td').eq(1).empty()
                                        .html(string).find('input').focus();
                                        string = '<input type="text" id="title" value="'+$(this).closest('tr').find('td').eq(0).html()+'">';
                                        $(this).closest('tr').find('td').eq(0).empty()
                                        .html(string).find('input').focus();
                                        $(this).closest('tr').find('td').eq(2)
                                        .html("<a id=save>Save</>");
                                        $(this).closest('tr').find('td').eq(4)
                                        .html("<a href=http://localhost:3000/articles>Cancel</>");
                                        $(this).closest('tr').find('td').eq(3)
                                        .html("Edit");
                                        $("#save").click(function(){
                                                            $.ajax({type: 'POST',
                                                                    url: "http://localhost:3000/v2/articles/update",
                                                                    //method: 'UPDATE',
                                                                    data: {id: id, title: $("#title").val(), text: $("#text").val()},
                                                                    success: function(data){
                                                                                //console.log(data);
                                                                                //string = '<id="text" value="'+$(this).closest('tr').find('td').eq(1).html()+'" disabled="disabled">';
                                                                                //$("#text").disabled = true;
                                                                                //$("#title").disabled = true;
                                                                                //$(this).closest('tr').find('td').eq(1).html(string);
                                                                                //$(this).closest('tr').find('td').eq(0).html($("#title").val());
                                                                                location.reload();
                                                                             }
                                                                    });
                                                        });
                                    });
        }
    });
});