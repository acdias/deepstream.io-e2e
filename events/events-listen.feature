@events
Feature: Events
	Events Listen are deepstream's active publish-subscribe
	providers.

Scenario: Events

	# The client is connected
	Given the servers are ready
		And client 1 connects to server 1
		And client 1 logs in with username "XXX" and password "YYY"
		And client 2 connects to server 1
		And client 2 logs in with username "XXX" and password "YYY"

	# Client 1 subscribes to an event
	When client 1 listens to an event with pattern "event\/[a-z0-9]"
		And client 1 accepts a match "event/1" for pattern "event\/[a-z0-9]"
		And client 1 accepts a match "event/2" for pattern "event\/[a-z0-9]"
		And client 2 subscribes to an event named "event/1"
		And client 2 subscribes to an event named "event/2"
		And client 2 subscribes to an event named "weather"

	Then client 1 receives a match "event/1" for pattern "event\/[a-z0-9]"
		And client 1 receives a match "event/2" for pattern "event\/[a-z0-9]"
		And client 1 does not receive a match "weather" for pattern "event\/[a-z0-9]"

	Then the clients are stopped
		And the servers are stopped
