$(document).ready(function() {
  $('a.endorsements-link').on('click', function(event) {
    event.stopImmediatePropagation();
    event.preventDefault();
    var endorsementCount = $(this).siblings('.endorsements_count');

    $.post(this.href, function(response) {
      endorsementCount.text(response.new_endorsement_count);
    });
  });
});
