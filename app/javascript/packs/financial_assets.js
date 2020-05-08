require('chart.js')

var chart;

$(document).ready(function() {
  var datapointsNoDividends = $('#datapoints-no-dividends').data('datapoints');
  var datapointsWithDividends = $('#datapoints-with-dividends').data('datapoints');
  var labels = datapointsNoDividends.map(x => x[0]);
  var datapointsNoDividends = datapointsNoDividends.map(x => parseFloat(x[1]));
  var datapointsWithDividends = datapointsWithDividends.map(x => parseFloat(x[1]));

  var config = {
    type: 'line',
    data: {
      labels: labels,
      datasets: [
        {
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
          label: 'Dividends',
          data: datapointsWithDividends,
          lineTension: 0,
          backgroundColor: 'blue',
          borderColor: 'blue',
          fill: false,
          pointRadius: 0,
          pointHoverRadius: 0
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
