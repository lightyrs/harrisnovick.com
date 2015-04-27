$(function() {
  $('#stream').dcSocialStream({
    feeds: {
      twitter: {
        id: 'theMTA',
        images: 'small',
        replies: false,
        url: 'http://harrisnovick.com/2015/twitter.php'
      },
      youtube: {
        id: 'hnovick',
        feed: 'favorites'
      },
      lastfm: {
        id: 'hnovick',
        out: 'intro,thumb,title,text,user,share'
      },
      instagram: {
        id: '!7212',
        out: 'intro,thumb,text,user,share,meta',
        accessToken: '7212.58867cf.e8f161e71232403284a43be477def64a',
        clientId: '58867cf4eff442ed8f33a04ee6216fcd',
        comments: 3,
        likes: 10
      },
      dribbble: {
        id: 'lightyrs'
      },
      rss: {
        id: 'http://stackoverflow.com/feeds/user/111363,http://www.quora.com/Harris-Novick/rss,https://github.com/lightyrs.atom'
      }
    },
    rotate: {
      delay: 0
    },
    twitterId: 'theMTA',
    controls: true,
    filter: true,
    wall: true,
    limit: 15,
    max: 'limit',
	cache: false,
    iconPath: 'http://harrisnovick.com/2015/assets/img/stream/dcsns-dark/',
    imagePath: 'http://harrisnovick.com/2015/assets/img/stream/dcsns-dark/'
  });
});
