// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('.select2-theorem-claim').select2({
    // theme: "bootstrap",
    placeholder: 'Foglia',
    tags: true
  });

  $('.select2-theorem-claim').on('select2:select', function (e) {
    _this = $(this);
    console.log(e.params.data);
    var text = e.params.data.text
    $.ajax("/api/v1/claims/find_or_create", {
      data: {value: text}
    }).done(function(obj){
      console.log(obj)
      $(_this).append('<option selected value="'+ obj.id +'">' + obj.value + '</option>')
      $(_this).trigger('change');
    })
  });

  $('.select2-theorem-argument').select2({
    theme: "bootstrap",
    placeholder: 'Argomento',
    tags: true
  });
  

  $('.selectize-theorem-claim').selectize({
    plugins: ['restore_on_backspace'],
    valueField: 'id',
    labelField: 'value',
    searchField: 'value',
    delimiter: '',
    createOnBlur: true,
    persist: false,
    maxItems: 1,
    load: selectizeLoad,
    create: selectizeCreate,
    closeAfterSelect: true,
    score: function(search) {
      return function(item) {return item.score}
    },
    onType: function(str) {
      this.clearOptions();
    },
    dropdownParent: 'body',



    // render: option: (item, escape) ->
    //   '<div class="item_search">' + '<span class="title">' + '<span class="name">' + escape(item.name) + '</span>' + '<br><span>' + '<a href="#" class="sideboard" style="font-size:10px;z-index:1;">Add to Sideboard</a>&nbsp&nbsp' + '</span>' + '<span class="by">' + escape(item.edition_set_name) + ' </span>' +  '<span class="pull-right">'  + '<span>' + item.sell_price + '</span>' + '</span>' +'</span>'   + '</div>'
    // score: (search) ->
    //   score = @getScoreFunction(search)
    //   (item) ->
    //     score(item) * (1 + Math.min(item.number / 100, 1))
  })

  $(document).on('click', '[data-toggle="collapse"]', function() {
    $(this).find('.accordion').toggleClass('hidden');
  });

  function selectizeCreate(value, callback) {
    $.ajax("/api/v1/claims/find_or_create", {
      data: {value: value}
    }).done(function(obj){
      console.log(obj);
      callback({ 'id': obj.id, 'value': obj.value });
    })
  }

  function selectizeChange(value) {
    $.ajax("/api/v1/claims/find_or_create", {
      data: {value: value}
    })
  }

  function selectizeLoad(query, callback) {
    if (!query.length) {
      return callback()
    }
    $.ajax({
      url: '/api/v1/claims/search?q=' + encodeURIComponent(query),
      type: 'GET',
      error: function() {
        callback()
      },
      success: function(res) {
        console.log(query);
        console.table(res);
        callback(res.slice(0,30));
      }
    });
  }


});