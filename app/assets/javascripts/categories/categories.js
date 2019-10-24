EOC.CategoriesIndex = EOC.CategoriesShow = (() => {
  let button;

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
      button = $(event.relatedTarget);
      clearSelectedCategory();
      setupFormData();
      toggleCategoryList();
      disableCurrentCategory();
    });
  }

  function setupFormData() {
    let form = $('#move-category-form');
    const type = button.data('type');
    $(`#${type}-item`).val(button.data('id'));

    form.attr('action', form.data(`${type}-url`));
  }

  function addEventToCategoryList() {
    $('#category-list li').on('click', event => {
      event.stopPropagation();
      selectItem(event);
    });
  }

  function selectItem(event) {
    if ($(event.currentTarget).hasClass('disable')) {
      return;
    }

    $('#category-list .selected').removeClass('selected');
    const id = event.currentTarget.id;
    $(event.currentTarget).addClass('selected');
    $('#parent-category').val(id);
  }

  function clearSelectedCategory() {
    $('#category-item').val('');
    $('#sop-item').val('');
    $('#category-list .selected').removeClass('selected');
  }

  function toggleCategoryList() {
    $('#category-list li.hidden').removeClass('hidden');

    if (button.data('type') === 'category') {
      const id = button.data('id');
      $(`#category-list li#${id}`).addClass('hidden');
    }
  }

  function disableCurrentCategory() {
    $('#category-list li.disable').removeClass('disable');
    const currentCategoryId = $('#move-category-form').data('current-id');
    let parentCategory = currentCategoryId ? $(`#category-list li#${currentCategoryId}`) : $('#category-list li.root-category');
    parentCategory.addClass('disable');
  }

  function addEventToForm() {
    $('#move-category-form').submit( event => {
      if ($('#category-list .selected').length == 0) {
        event.preventDefault();
      }
    });
  }
})();
