// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
/**
 * Dark theme for Highcharts JS
 * @author Torstein Honsi
 */

$(function () {
	var average_response_time = new Highcharts.Chart({
        chart: {
            renderTo: 'average_response',
            type: 'line'
        },
        title: {
            text: 'Average First Response Time',
            x: -20 //center
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            },
            pointInterval: 24 * 3600 * 1000 * 1000
        },
        yAxis: {
            title: {
                text: 'Time (HH:MM:SS)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            pointFormat: '{point.y}'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: gon.archived_tickets
        }]
    });
});

$(function () {
	var average_time_archive = new Highcharts.Chart({
        chart: {
            renderTo: 'average_time_archive',
            type: 'line'
        },
        title: {
            text: 'Average Time to Archive',
            x: -20 //center
        },
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            }
        },
        yAxis: {
            title: {
                text: 'Time (HH:MM:SS)'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            pointFormat: '{point.y}'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: gon.archived_tickets
        }]
    });
});

$(function () {
	var archived_tickets = new Highcharts.Chart({
        chart: {
            renderTo: 'archived_tickets',
            type: 'line'
        },
        title: {
            text: 'Archived Tickets',
            x: -20 //center
        },
        xAxis: {
            type: "datetime",
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            }
        },
        yAxis: {
            title: {
                text: 'Count'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            pointFormat: '{point.y}'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: gon.archived_tickets
        }]
    });
});

$(function () {
    var replies = new Highcharts.Chart({
        chart: {
            renderTo: 'replies',
            type: 'line'
        },
        title: {
            text: 'Replies',
            x: -20 //center
        },
        series: [{
            type:"line",
            data: gon.replies_count
        }],
        xAxis: {
            type: 'datetime',
            dateTimeLabelFormats: { // don't display the dummy year
                month: '%e. %b',
                year: '%b'
            }
        },
        yAxis: {
            title: {
                text: 'Count'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            pointFormat: '{point.y}'
        },
        legend: {
            enabled: false
        }
    });
});
// Tickets chart //

$(function () {
	var tickets = new Highcharts.Chart({
        chart: {
            renderTo: 'tickets',
            type: 'line'
        },
        title: {
            text: 'Tickets',
            x: -20 //center
        },
        xAxis: {
            labels: {
                style: {
                    fontSize:'15px'
                }
            },
            type: 'datetime',
            dateTimeLabelFormats: {
                month: '%b %e'
            }
        },
        yAxis: {
            title: {
                text: 'Count'
            },
            plotLines: [{
                value: 0,
                width: 1,
                color: '#808080'
            }]
        },
        tooltip: {
            pointFormat: '{point.y}'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: gon.tickets_count
        }]
    });
});
