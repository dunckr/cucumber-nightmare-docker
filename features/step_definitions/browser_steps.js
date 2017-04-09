const expect = require('expect');

module.exports = function () {
	this.Given(/^I am on the "([^"]*)" website$/, function (website, callback) {
		this.nightmare
			.goto(`https://${website}`)
			.then(function() {
				callback();
			});
	});

	this.When(/^I type in "([^"]*)"$/, function (text, callback) {
		this.nightmare
			.type('#search_form_input_homepage', text)
			.then(function() {
				callback();
			});
	});

	this.Then(/^I click on the "([^"]*)" button$/, function (id, callback) {
		this.nightmare
			.click(id)
			.wait('#zero_click_wrapper .c-info__title a')
			.then(function() {
				callback();
			});
	});

	this.Then(/^I should see the link "([^"]*)"$/, function (link, callback) {
		this.nightmare
			.evaluate(() => {
				return document.querySelector('#zero_click_wrapper .c-info__title a').href;
			})
			.then(function(result) {
				expect(link).toEqual(result);
				callback();
			});
	});
}
