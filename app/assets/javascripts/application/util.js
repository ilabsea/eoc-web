EOC.Util = {
  capitalize(value) {
    return value.replace(/(^|\s)([a-z])/g, (m, p1, p2) => p1 + p2.toUpperCase());
  },

  getCurrentPage() {
    if (!$('body').attr('id')) {
      return '';
    }

    const bodyId = $('body').attr('id').split('-');
    const action = this.capitalize(bodyId.pop());
    const controller = bodyId;

    for (let i = 0; i < controller.length; i += 1) {
      controller[i] = this.capitalize(controller[i]);
    }

    const pageName = controller.join('') + action;

    return pageName;
  },
};
