EOC.SopsNew = EOC.SopsEdit = EOC.SopsCreate = EOC.SopsUpdate = (() => {
  return {
    init,
  };

  function init() {
    onChangeFile();
    onClickRemoveFile();
    initTagEditor();
    onSubmit();
  }

  function initTagEditor() {
    var input = document.querySelector('input[name="sop[tags]"]');
    new Tagify(input);
  }

  function onClickRemoveFile() {
    $('.remove-file').off('click');
    $('.remove-file').on('click', event => {
      removeFile(event);
      event.preventDefault();
    });
  }

  function removeFile(event) {
    const dom = event.currentTarget;
    $(dom).hide();
    $(dom).next().hide();
    $(dom).prev().val(1);
  }

  function onChangeFile() {
    $('.file-input').off('change');
    $('.file-input').change(() => {
      const parent = $(this).parent();
      parent.find('input.destroy[type=hidden]').val(0);
    });
  }

  function initSelectPicker() {
    $('.selectpicker').selectpicker();
  }

  function readURL(input) {
    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = e => {
        const parent = $(input).parent();
        const img = parent.find('img');
        const btnRemoveImage = parent.find('.remove-image');
        const hiddenField = parent.find('input[type=hidden]');

        $(img).attr('src', e.target.result);
        $(btnRemoveImage).show();
        $(hiddenField).val('0');
      };

      reader.readAsDataURL(input.files[0]);
    }
  }

  function onSubmit() {
    $('#sop-form').submit(event => {
      const tags = $('#sop-tags').val();
      if (tags.length) {
        const transformValue = JSON.parse(tags).map(x => x.value);
        $('#sop-tags').val(transformValue.join(','));
      }
    });
  }
})();
