LegAlerts = {
  unfollow: function(btn) {
    var bill_id = btn.data('billId');
    var url = '/bills/'+bill_id+'/unfollow';
    $.post(url, btn.data(), function(rsp) {
      console.log('rsp', rsp);
    })
    .fail(function() {
      btn.text('Following');
      LegAlerts.toggleFollow(btn);
    });
  },

  follow: function(btn) {
    var bill_id = btn.data('billId');
    var url = '/bills/'+bill_id+'/follow';
    $.post(url, btn.data(), function(rsp) {
      console.log('rsp', rsp);
    })
    .fail(function() {
      btn.text('Follow');
      LegAlerts.toggleFollow(btn);
    });
  },

  toggleFollow: function(btn) {
    btn.toggleClass('following');
    btn.toggleClass('follow');
    btn.toggleClass('btn-success');
    btn.toggleClass('btn-default');
  },

  handleFollows: function(btn) {
    btn.click(function() {
      if (btn.hasClass('following')) {
        btn.text('Follow');
        LegAlerts.unfollow(btn);
      }
      else {
        btn.text('Following');
        LegAlerts.follow(btn);
      }
      LegAlerts.toggleFollow(btn);
    });
  }
}
