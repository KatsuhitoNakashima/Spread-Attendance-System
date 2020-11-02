var nowTime = new Date(); //  現在日時を得る
var nowHour = nowTime.getHours(); // 時を抜き出す
var nowMin  = nowTime.getMinutes(); // 分を抜き出す
var nowSec  = nowTime.getSeconds(); // 秒を抜き出す
var msg = "現在時刻は、" + nowHour + ":" + nowMin + ":" + nowSec + " です。";
document.getElementById("RealtimeClockArea").innerHTML = msg;
