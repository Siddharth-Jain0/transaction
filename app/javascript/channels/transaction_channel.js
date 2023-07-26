import consumer from "channels/consumer"
import * as ActionCable from '@rails/actioncable'

consumer.subscriptions.create("TransactionChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("hello this is transaction controller")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    var dataArray = [{ value1: data[0].id, value2: data[1].name, value3: data[2].name , value4: data[1].upi , value5: data[2].upi , value6: data[0].amount , value7: data[0].option, value8: data[0].status}];
    console.log('Received data in the channel:', dataArray);
    console.log('Received data in the channel:', data);
    $(document).ready(function() {
      $.each(dataArray, function(index, item) {
        var row = $('<tr>'); 
        row.append($('<td>').text(item.value1));
        row.append($('<td>').text(item.value2));
        row.append($('<td>').text(item.value3));
        row.append($('<td>').text(item.value4));
        row.append($('<td>').text(item.value5));
        row.append($('<td>').text(item.value6));
        row.append($('<td>').text(item.value7));
        row.append($('<td>').text(item.value8));
        var selector = '#myTable' +data[1].id+ ' tbody';
        $(selector).prepend(row);
        var select = '#myTable' +data[2].id+ ' tbody';
        $(select).append(row);
      });
    });
  }
});
