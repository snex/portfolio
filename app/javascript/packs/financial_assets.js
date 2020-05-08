require('chart.js')

var chart;

$(document).ready(function() {
  var labels = $('#datapoints-no-dividends').data('datapoints').map(x => x[0]);
  var datapointsNoDividends = $('#datapoints-no-dividends').data('datapoints').map(x => parseFloat(x[1]));
  var datapointsWithDividends = $('#datapoints-with-dividends').data('datapoints').map(x => parseFloat(x[1]));
  var investmentData = $('#investment-data').data('datapoints').map(x => parseFloat(x));
  var dividendData = $('#dividend-data').data('datapoints').map(x => parseFloat(x));

  var config = {
    type: 'line',
    data: {
      labels: labels,
      datasets: [
        {
          type: 'line',
          label: 'No Dividends',
          data: datapointsNoDividends,
          lineTension: 0,
          backgroundColor: 'red',
          borderColor: 'red',
          fill: false,
          pointRadius: 0,
          pointHoverRadius: 0
        },
        {
          type: 'line',
          label: 'Dividends',
          data: datapointsWithDividends,
          lineTension: 0,
          backgroundColor: 'blue',
          borderColor: 'blue',
          fill: false,
          pointRadius: 0,
          pointHoverRadius: 0
        },
        {
          type: 'bar',
          label: 'Investments',
          data: investmentData,
          backgroundColor: 'yellow',
          borderColor: 'yellow'
        },
        {
          type: 'bar',
          label: 'Dividends',
          data: dividendData,
          backgroundColor: 'green',
          borderColor: 'green'
        }
      ]
    },
    options: {
      responsive: true,
      tooltips: {
        mode: 'index',
        intersect: false
      }
    }
  }

  var ctx = $('#datachart').get(0).getContext('2d');
  var chart = new Chart(ctx, config);
});
