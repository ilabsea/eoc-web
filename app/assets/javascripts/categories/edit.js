EOC.CategoriesNew = EOC.CategoriesEdit = EOC.CategoriesCreate = EOC.CategoriesUpdate = (() => {
  return {
    init,
  };

  function init() {
    initTagEditor();
    onSubmit();
  }

  function initTagEditor() {
    const input = document.querySelector('input[name="category[tags]"]');
    new Tagify(input, {delimiters: ' '});
  }

  function onSubmit() {
    $('#category-form').submit(event => {
      const tags = $('#category-tags').val();
      if (tags.length) {
        const transformValue = JSON.parse(tags).map(x => x.value);
        $('#category-tags').val(transformValue.join(' '));
      }
    });
  }
})();
