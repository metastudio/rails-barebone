(function() {
  $(function() {
    $('.table_tools li.scope.sorted > a').click(function(e) {
      e.preventDefault();
      window.location.replace(location.pathname);
    });
  });
}).call(this);
