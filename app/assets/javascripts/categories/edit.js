EOC.CategoriesNew = EOC.CategoriesEdit = EOC.CategoriesCreate = EOC.CategoriesUpdate = (() => {
  return {
    init,
  }

  function init() {
    initTagEditor();
  }

  function initTagEditor() {
    const input = document.querySelector('input[name="category[tags]"]');
    new Tagify(input);
  }
})();
