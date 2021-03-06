// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require select2-full
//= require cocoon
//= require filterrific/filterrific-jquery
//= require bootstrap-markdown-bundle
//= require Chart.bundle
//= require chartkick
//= require turbolinks
//= require turbolinks-compatibility
//= require_tree .


$(document).ready(function() {
    $("#creator_names").select2({
        tags: true,
        tokenSeparators: [';'],
        theme: "bootstrap"
    });
    $("#tag_names").select2({
        tags: true,
        tokenSeparators: [','],
        theme: "bootstrap"
    });
    $("#place").select2({
        tags: true,
        theme: "bootstrap",
        placeholder: "Select a city",
        allowClear: true
    });
    $("#publisher").select2({
        tags: true,
        theme: "bootstrap",
        placeholder: "Select a publisher",
        allowClear: true
    });
    $("#serie_name").select2({
        tags: true,
        theme: "bootstrap",
        placeholder: "Select a Serial or journal",
        allowClear: true
    });
    $("#parent_entry_id").select2({
        theme: "bootstrap",
        placeholder: "Select a parent",
        allowClear: true
    });

    $("select").on("select2:select", function(evt) {
        var element = evt.params.data.element;
        var $element = $(element);

        $element.detach();
        $(this).append($element);
        $(this).trigger("change");
    });

});