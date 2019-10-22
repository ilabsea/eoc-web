EOC.CategoriesIndex = EOC.CategoriesShow = (() => {

  return {
    init,
  };

  function init() {
    addEventToButton();
    addEventToCategoryList();
  }

  function addEventToButton() {
    let form = $('#move-category-form');
    let url;
    $('#category-modal').on('show.bs.modal', event => {
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
      $(event.currentTarget).addClass('selected');
      $('#parent-category').val(event.currentTarget.id);
    });
  }
})();
