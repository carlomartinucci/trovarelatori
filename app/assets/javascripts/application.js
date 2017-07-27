// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap_sb_admin_base_v2
//= require select2-full
//= require selectize
//= require restore_on_backspace/plugin
//= require toastr
//= require_tree .



function toggleFormWrapper(query) {
  if (query) {
    $(".search-form-wrapper").removeClass("search-index").addClass("search-show");
  } else {
    $(".search-form-wrapper").addClass("search-index").removeClass("search-show");
  }
}

function toggleSuggested(query) {
  if (query) {
    $("#suggested").hide();
  } else {
    $("#suggested").show();
  }
}

$(document).on("click", '[data-form="true"]', function(e){
  e.preventDefault();
  var form = $("form#known-topic-for-topic-" + $(this).data("topic-id"))
  $(form).find(".form-knowledge").val($(this).data("knowledge"));
  $(form).submit();
});

$(document).on("click", ".btn-edit-mode", function(){
  $(".show-mode").removeClass("show-mode").addClass("edit-mode");
});
$(document).on("click", ".btn-show-mode", function(){
  $(".edit-mode").removeClass("edit-mode").addClass("show-mode");
});

$(document).on("click", ".show-more", function(e){
  e.preventDefault();
  $(".tr-theme-" + $(this).data("theme-id")).removeClass("hidden");
  $(this).parents("tr").remove();
});
