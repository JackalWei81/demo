$(function(){

   var note = $('#note');
   var t_now = new Date().getTime();
   var t_target = new Date(2016, 8, 26, 13, 45, 0);
   var t_diff;

   if(t_target > t_now){
     t_diff = t_target - t_now;
   }
   var ts = t_now + t_diff;

   $('#countdown').countdown({
     timestamp : ts,
     callback  : function(days, hours, minutes, seconds){

       var message = "";

       message += days + " day" + ( days==1 ? '':'s' ) + ", ";
       message += hours + " hour" + ( hours==1 ? '':'s' ) + ", ";
       message += minutes + " minute" + ( minutes==1 ? '':'s' ) + " and ";
       message += seconds + " second" + ( seconds==1 ? '':'s' ) + " <br />";

      note.html(message);
     }
   });
 });