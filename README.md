# README

You will need an API key from [IEXCLOUD.IO](https://iexcloud.io/). Put it into Rails.application.credentials.iex_api_key

Run "bundle exec whenever --write-crontab" to set up the daily cron task.

If your portfolio contains mutual funds, when entering dividend payouts, it is advisable to enter them on the business day *prior* to the payout date, otherwise you may see odd dips in your graphs due to the way mutual fund dividend/distribution reinvestments work.
