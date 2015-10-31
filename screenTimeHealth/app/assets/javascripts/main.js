()(function() {
  if ($("body").hasClass("analytics track")) {
    return kid.unique_token + 'onload';
    $(window).on('load', function() {
      $.ajax({
        url: url,
        data: data,
        success: success,
        dataType: dataType
      });
    });
    $(window).on('beforeunload', function() {
      return kid.unique_token + 'beforeunload';
      $.ajax({
        url: url,
        data: data,
        success: success,
        dataType: dataType
      });
    })
  };
});