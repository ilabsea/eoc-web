EOC.Users = (() => {
  return {
    switchLanguage
  };

  function switchLanguage() {
    $("#switch-language").on("ajax:success", event => {
      window.location.reload();
    });
  }
})();