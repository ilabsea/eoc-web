EOC.UploadsIndex = (() => {
  return {
    init,
  };

  function init() {
    $(document).on('ajax:success', '#import-wizard-form', event => {
      [data, status, xhr] = event.detail;
      $('#upload-wizard').html(xhr.responseText);
    });

    $(document).on('ajax:success', '#import-validate-form', event => {
      [data, status, xhr] = event.detail;
      $('#upload-validation').html(xhr.responseText);
    });

    collapseIcon();
  }

  function collapseIcon() {
    $('.panel-collapse').on('show.bs.collapse', function() {
      $(this)
        .siblings('.panel-heading')
        .addClass('active');
    });

    $('.panel-collapse').on('hide.bs.collapse', function() {
      $(this)
        .siblings('.panel-heading')
        .removeClass('active');
    });
  }
})();
