package it.ht.rcs.console.utils
{
  import locale.R;
  
  import mx.formatters.DateFormatter;

  public class TimeUtils
  {
    
    public static function timestampDiffFromNow(t:Number):String
    {
      var diff:Number = Clock.instance.now.time - t * 1000;
      var days:int = diff / 1000 / 60 / 60 / 24;
      
      /* prevent negative differences */
      if (diff < 0) 
        diff = 0;
      
      var time:Date = new Date();
      /* reset the time to 1 jan 1970 (to avoid DST) */
      time.setTime(0);
      /* calculate the difference (without the timezone) */
      time.setTime(diff + time.timezoneOffset*60*1000);
      
      var clockFormatter:DateFormatter = new DateFormatter();
      clockFormatter.formatString = "JJ:NN:SS";
      
      if (days > 0)
        return days.toString() + ' days, ' + clockFormatter.format(time);
      else
        return clockFormatter.format(time); 
    }
    
    public static function timestampFormatter(t:Number):String
    {
      if (t == 0)
        return R.get('NEVER');
        
      var date:Date = new Date();
      /* get the current offset from UTC */
      var currentOffset:Number = date.timezoneOffset * 60 * 1000;
      
      /* going back to UTC, then add the console offset */ 
      date.setTime(t + currentOffset + Clock.instance.consoleTimeZoneOffset);
      
      /* format the date */
      var clockFormatter:DateFormatter = new DateFormatter();
      clockFormatter.formatString = "YYYY-MM-DD JJ:NN:SS";
      return clockFormatter.format(date);
    }

    public static function timestampDateFormatter(t:Number):String
    {
      if (t == 0)
        return R.get('NEVER');
      
      var date:Date = new Date();
      /* get the current offset from UTC */
      var currentOffset:Number = date.timezoneOffset * 60 * 1000;
      
      /* going back to UTC, then add the console offset */ 
      date.setTime(t + currentOffset + Clock.instance.consoleTimeZoneOffset);
      
      /* format the date */
      var clockFormatter:DateFormatter = new DateFormatter();
      clockFormatter.formatString = "DD MMM YYYY";
      return clockFormatter.format(date);
    }

    
    public static function zeroPad(number:Number, width:int):String
    {
      var ret:String = "" + number;
      while( ret.length < width )
        ret = "0" + ret;
      return ret;
    }
    
    public static function formatTime(time:Number):String
    {
      var formatted:String="";
      var d:Date=new Date(time)
      formatted+=doubleDigits(d.hoursUTC)+":"+doubleDigits(d.minutesUTC)+":"+doubleDigits(d.secondsUTC);
      return formatted;
    }
    
    public static function doubleDigits(value:Number):String
    {
      var formatted:String;
      if(value<=9){
        return String("0"+value);
      }else{
        return String(value);
      }
    }
    
  }
  
}