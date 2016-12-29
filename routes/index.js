const Configstore = require('configstore');
const conf = new Configstore('harrisnovick');

var express = require('express');
var router = express.Router();
var Twitter = require('twitter');
var twitter = new Twitter({
  consumer_key: conf.get('twitter.consumerKey'),
  consumer_secret: conf.get('twitter.consumerSecret'),
  access_token_key: conf.get('twitter.accessToken'),
  access_token_secret: conf.get('twitter.accessTokenSecret')
});

/* GET home page. */
router.get('/', function(req, res, next) {
  res.status(200).render('index', { quotation: 'Aquaman is a superhero appearing in comic book titles by DC Comics. Created by Paul Norris and Mort Weisinger' });
  // twitter.get('statuses/user_timeline', { screen_name: 'theMTA', count: 1 },  function(error, tweets, response) {
  //   if (!error) {
  //     console.log(tweets[0]);
  //     res.status(200).render('index', { title: 'Harris Novick', tweet: tweets[0].text });
  //   }
  //   else {
  //     res.status(500).json({ error: error });
  //   }
  // });
});

module.exports = router;
