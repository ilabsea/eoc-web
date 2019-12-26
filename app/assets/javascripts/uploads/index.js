EOC.UploadsIndex = (() => {
  return {
    init,
  };

  function init() {
    $("#import-wizard-form").on('ajax:success', event => {
      [data, status, xhr] = event.detail;
      $('#upload-wizard').html(xhr.responseText);
    });
  }
})();
