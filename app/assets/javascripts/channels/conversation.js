App.conversations = App.cable.subscriptions.create("ConversationChannel", {
    collection: function() {
        return $("[data-channel='new_message']");
    },
    connected: function() {
        return setTimeout((function(_this) {
            return function() {
                _this.followCurrentMessage();
                return _this.installPageChangeCallback();
            };
        })(this), 1000);
    },
    received: function(data) {
        console.log("data: ", data);
        return this.collection().append(this.renderMessage(data));
    },
    followCurrentMessage: function() {
        var userId;
        if (userId = this.collection().data('user-id')) {
            return this.perform('follow', {
                user_id: userId
            });
        } else {
            return this.perform('unfollow');
        }
    },
    renderMessage: function(data) {
        console.log("renderMessageData:");
        console.log(data);
        console.log(data.text);
        // return '<div class=\'alert alert-warning\'><span>' + data.user + ' added an expense </span><br>' + this.renderAmount(data.amount) + ' €<b>,</b> ' + data.description + '</div>';
        return '<div class=\'alert alert-warning\'>' +
               '<span>somebody sent you a new message: <br> <a href="/conversations/' + data.conversation_id + '">check it out</a>' +
               '</span></div>';
    },
    // renderAmount: function(amount) {
    //     console.log("Amount:", amount);
    //     return parseFloat(amount).toFixed(2);
    // },
    installPageChangeCallback: function() {
        if (!this.installedPageChangeCallback) {
            return this.installedPageChangeCallback = true;
        }
    }
});

$(document).on('turbolinks:load', function() {
    return App.conversations.followCurrentMessage();
});

// ---
// generated by coffee-script 1.9.2