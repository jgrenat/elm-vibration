//import Native.Utils //
//import Native.Scheduler //

var _JohnBugner$elm_vibration$Native_Vibration = function() {
	function vibrateInPattern(pattern) {
		return _elm_lang$core$Native_Scheduler.nativeBinding(function(callback) {
			window.navigator.vibrate(_elm_lang$core$Native_List.toArray(pattern));

			return callback(_elm_lang$core$Native_Scheduler.succeed(_elm_lang$core$Native_Utils.Tuple0));
		});
	}

	return {
		vibrateInPattern : vibrateInPattern,
	};
}();
