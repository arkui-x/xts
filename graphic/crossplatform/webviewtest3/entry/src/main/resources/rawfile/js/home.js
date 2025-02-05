/*
 * Copyright (c) Huawei Technology Co., Ltd. 2023.
 */
// @ts-nocheck
'use strict';
const barchartPts10 = null;
const barchartPts20 = null;
const barchartPts30 = null;

function init() {
    const barchart1 = document.getElementById('barchart_1');
    const barchart2 = document.getElementById('barchart_2');
    const barchart3 = document.getElementById('barchart_3');
    const option1 = {
        color: ['#52894e'],
        grid: {
            left: '20%',
            right: '20%',
        },
        xAxis: {
		    type: 'category',
            data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        },
        yAxis: {
            type: 'value',
            alignTicks: true,
            axisLine: {
                show: true,
            },
        },
        // 柱图数据
        series: [
            {
                // 图形样式：柱图
                type: 'bar',
                data: [120, 199, 150, 180, 70, 110, 130],
                showBackground: true,
            },
        ],
    };
    const option2 = {
        color: ['#1c68d4'],
        grid: {
            left: '20%',
            right: '20%',
        },
        // x轴数据
        xAxis: {
            type: 'category',
            data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月'],
        },
        yAxis: {
            type: 'value',
            alignTicks: true,
            axisLine: {
                show: true,
            },
        },
        // 柱图数据
        series: [
            {
                // 图形样式：柱图
                type: 'bar',
                data: [1213, 30, 150, 80, 70, 910, 630],
                showBackground: true,
            },
        ],
    };
    const option3 = {
        grid: {
            left: '20%',
            right: '20%',
        },
        // x轴数据
        xAxis: {
            type: 'category',
            data: ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
        },
        yAxis: {
            type: 'value',
            alignTicks: true,
            axisLine: {
                show: true,
            },
        },
        // 柱图数据
        series: [
            {
                // 图形样式：柱图
                type: 'bar',
                data: [0.01, 0.2, 0.05, 0.07, 0.04, 0.13, 0.9],
                showBackground: true,
            },
        ],
    };
    barchartPts10 = echarts.init(barchart1);
    barchartPts20 = echarts.init(barchart2);
    barchartPts30 = echarts.init(barchart3);

    barchartPts10.setOption(option1);
    barchartPts20.setOption(option2);
    barchartPts30.setOption(option3);

    window.addEventListener('resize', (event) => {
        barchartPts10.resize();
        barchartPts20.resize();
        barchartPts30.resize();
    });
}

function barChartResize() {
    barchartPts10.resize();
    barchartPts20.resize();
    barchartPts30.resize();
}

(function () {
    init();
})();
