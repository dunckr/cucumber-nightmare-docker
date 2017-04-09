const Nightmare = require('nightmare');
const GUI = !!process.env.GUI;

module.exports = function() {
	this.Before(function(scenario, callback) {
		this.nightmare = Nightmare({
			openDevTools: GUI,
			show: GUI,
		});
		callback();
	});

	this.After(function(scenario, callback) {
		this.nightmare
			.end()
			.then(() => {
				callback();
			});
	});
};
