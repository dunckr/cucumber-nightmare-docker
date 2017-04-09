Feature: DuckDuckGo

	As a user of DuckDuckGo
	I want to be able to search for a term
	So that I see suggestions

	Scenario: Reading documentation
		Given I am on the "DuckDuckGo.com" website
		When I type in "github nightmare"
		Then I click on the "#search_button_homepage" button
		Then I should see the link "https://github.com/segmentio/nightmare"
