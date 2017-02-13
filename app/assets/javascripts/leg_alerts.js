LegAlerts = {
  unfollow: function(btn) {
    var bill_id = btn.data('billId');
    var url = '/bills/'+bill_id+'/unfollow';
    $.post(url, btn.data(), function(rsp) {
      //console.log('rsp', rsp);
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
      //console.log('rsp', rsp);
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
  },

  showBillDetails: function(bill) {
    var modal = $('#bill-details-modal');
    modal.find('.ajax-loader').hide();
    modal.on('hide.bs.modal', function() {
      modal.find('.ajax-loader').show();
    });
    modal.find('.modal-title').text(bill.bill_id);
    var actions_html = [];
    $.each(bill.actions.reverse(), function(idx) {
      var action = this;
      var html = action.date.replace(/\ .+/, '');
      html += '<br/>' + action.action;
      actions_html.push('<div class="action">'+html+'</div>');
    });
    modal.find('.title').text(bill.title);
    modal.find('.actions').html(actions_html.join(''));
  }
}
