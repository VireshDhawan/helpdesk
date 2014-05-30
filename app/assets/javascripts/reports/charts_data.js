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
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
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
            valueSuffix: ' min'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
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
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
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
            valueSuffix: ' min'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
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
            type: "datetime"
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
            valueSuffix: ' min'
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
        xAxis: {
            type: 'datetime'
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
            valueSuffix: ' min'
        },
        legend: {
        	enabled: false
        },
        series: [{
        	type:"line",
            data: gon.replies_count
        }]
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
            type: "datetime"
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
            valueSuffix: ' min'
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
