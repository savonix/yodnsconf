


$('document').ready(function() {
  $('#select_all').toggle(
    function() {
      targets = "." + $(this).attr('class') + "s";
      $(targets).each(function(i) {
        $(this).attr("checked", "checked");
      });
    },
    function() {
      targets = "." + $(this).attr('class') + "s";
      $(targets).each(function(i) {
        $(this).attr("checked", "");
      });
    }
  );
});
