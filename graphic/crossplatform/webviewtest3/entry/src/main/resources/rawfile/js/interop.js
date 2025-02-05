/*
 * Copyright (c) Huawei Technology Co., Ltd. 2023.
 */
// @ts-nocheck
'use strict';
(function () {
    const screenSelector = document.querySelector('#screen-selector'); // JS Interop 下拉框
    const valueField = document.querySelector('#value'); // JS Interop计数框的值
    const incrementButton = document.querySelector('#increment'); // JS Interop点击按钮
    const counter = document.querySelector('#counter'); // counter中的计数值
    const counterBtn = document.querySelector('#countBtn'); // counter中的计数值
    const textField = document.querySelector('#textField'); // textfield
    const custom = document.querySelector('#custom'); // customer app
    const counterIncrement = document.querySelector('#counter_increment'); // counter中的点击按钮
    valueField.setAttribute('value', 0);
    /* 设置下拉框变更事件 */
    screenSelector.addEventListener('change', (event) => {
        const enabled = event.target.value === 'counter';
        valueField.disabled = !enabled;
        incrementButton.disabled = !enabled;
        switch (event.target.value) {
            case 'counter':
                counter.classList.remove('hide');
                textField.classList.add('hide');
                custom.classList.add('hide');
                break;
            case 'textField':
                counter.classList.add('hide');
                textField.classList.remove('hide');
                custom.classList.add('hide');
                break;
            case 'custom':
                counter.classList.add('hide');
                textField.classList.add('hide');
                custom.classList.remove('hide');
                break;
            default:
                break;
        }
    });
    /* 设置JS Interop计数按钮点击事件 */
    incrementButton.addEventListener('click', (event) => {
        let value = valueField.getAttribute('value');
        valueField.setAttribute('value', ++value);
        counterBtn.innerHTML = value;
    });
    /* 设置counter内计数按钮点击事件 */
    counterIncrement.addEventListener('click', (event) => {
        let value = valueField.getAttribute('value');
        valueField.setAttribute('value', ++value);
        counterBtn.innerHTML = value;
    });
})();
function customerOnInput(value) {
    const customerInput = document.getElementById('customerInput');
    customerInput.innerHTML = value.length;
}

function resetCustomerInput(e) {
    e.target.previousElementSibling.value = '';
    e.target.parentElement.previousElementSibling.children[1].children[0].innerHTML = 0;
}
