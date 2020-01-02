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
    let arrowDown = 'fa-angle-down';
    let arrowUp = 'fa-angle-up';
    $(document).on('show.bs.collapse', '.validate-result', e => {
      $(e.currentTarget)
        .find(`.${arrowDown}`)
        .addClass(arrowUp)
        .removeClass(arrowDown);
    });

    $(document).on('hide.bs.collapse', '.validate-result', e => {
      $(e.currentTarget)
        .find(`.${arrowUp}`)
        .addClass(arrowDown)
        .removeClass(arrowUp);
    });
  }
})();
