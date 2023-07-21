import consumer from "channels/consumer"
import * as ActionCable from '@rails/actioncable'

consumer.subscriptions.create("LoanChannel", {
  connected() {
    console.log("connected to loan  channel")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('Received data in the channel:', data);
    var dataArray = [{ value1: data.id, value2: data.principal, value3: parseFloat(data.monthly_rate).toFixed(4) , value4: data.time , value5: parseFloat(data.emi_amount).toFixed(2), value6: data.status,value7:"",value8:"" }];
    console.log('Received data in the channel:', dataArray);
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
          var selector = '#loantable tbody';
          $(selector).append(row);
        });
    });
  }
});
