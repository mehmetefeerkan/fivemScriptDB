var count = 0;
var thisCount = 0;


const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width = ((data.idx / count) * 100) + '%';
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;
        document.querySelector('.progress').style.left = '0%';
        document.querySelector('.progress').style.width = ((thisCount / count) * 100) + '%';
    },
};

window.addEventListener('message', function (e) {
    (handlers[e.data.eventName] || function () { })(e.data);
});