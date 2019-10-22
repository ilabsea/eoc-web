EOC.CategoriesIndex = EOC.CategoriesShow = (() => {

  return {
    init,
  };

  function init() {
    addEventToButton();
    addEventToCategoryList();
    addEventToForm();
  }

  function addEventToButton() {
    $('#category-modal').on('show.bs.modal', event => {
      let form = $('#move-category-form');
      const button = $(event.relatedTarget);
      const type = button.data('type');
      $(`#${type}-item`).val(button.data('id'));

      form.attr('action', form.data(`${type}-url`));
    });
  }

  function addEventToCategoryList() {
    $('#category-list li').on('click', event => {
      event.stopPropagation();
      $('#category-list .selected').removeClass('selected');
      selectItem(event);
    });
  }

  function selectItem(event) {
    const currentId = $('#move-category-form').data('current-id') || '';
    if (!isCurrentParent(event.currentTarget.id)) {
      $(event.currentTarget).addClass('selected');
      $('#parent-category').val(event.currentTarget.id);
    }
  }

  function isCurrentParent(id) {
    const currentId = $('#move-category-form').data('current-id') || '';
    return currentId == id;
  }

  function isSelf(id) {
    
  }

  function addEventToForm() {
    $('#move-category-form').submit( event => {
      if ($('#category-list .selected').length == 0) {
        event.preventDefault();
      }
    });
  }
})();
