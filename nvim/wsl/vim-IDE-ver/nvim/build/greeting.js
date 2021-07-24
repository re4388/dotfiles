var Time = /** @class */ (function () {
    function Time(timestamp) {
        this.timestamp = timestamp;
    }
    Time.prototype.label = function () {
        var message;
        var hour = this.timestamp.getHours();
        if (hour < 12 && hour > 6) {
            message = 1;
        }
        else if (hour < 18) {
            message = "afternoon";
        }
        else if (hour < 21) {
            message = "evening";
        }
        else {
            message = "night";
        }
        return message;
    };
    return Time;
}());
function greeting() {
    var now = new Time('now');
    return "Good " + now.label();
}
document.body.innerHTML = greeting();
