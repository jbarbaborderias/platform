@exportjobs @hxlEnabled
Feature: Testing the Export Job API for HXL
  Scenario: Create a export job with send_to_browser=true
    Given that I want to make a new "ExportJob"
    And that the oauth token is "testadminuser"
    And that the request "data" is:
    """
      {
        "send_to_browser": true,
        "send_to_hdx": true,
        "fields":"test",
        "filters":
        {
          "status" : ["published","draft"],
          "has_location" : "all",
          "orderby" : "created",
          "order" : "desc",
          "order_unlocked_on_top" : "true",
          "source" : ["sms","twitter","web","email"]
        },
        "entity_type":"post"
      }
    """
    When I request "/exports/jobs"
    Then the response is JSON
    And the response has a "errors" property
    And the "errors.1.title" property equals "send_to_hdx should be true when send_to_browser is false"
    Then the guzzle status code should be 422
  Scenario: Create a export job with send_to_browser=false
    Given that I want to make a new "ExportJob"
    And that the oauth token is "testadminuser"
    And that the request "data" is:
    """
      {
        "send_to_browser": false,
        "send_to_hdx": false,
        "fields":"test",
        "filters":
        {
          "status" : ["published","draft"],
          "has_location" : "all",
          "orderby" : "created",
          "order" : "desc",
          "order_unlocked_on_top" : "true",
          "source" : ["sms","twitter","web","email"]
        },
        "entity_type":"post"
      }
    """
    When I request "/exports/jobs"
    Then the response is JSON
    And the response has a "errors" property
    And the "errors.1.title" property equals "send_to_hdx should be true when send_to_browser is false"
    Then the guzzle status code should be 422
  Scenario: Create a export job for hdx
    Given that I want to make a new "ExportJob"
    And that the oauth token is "testadminuser"
    And that the request "data" is:
    """
      {
        "send_to_browser": false,
        "send_to_hdx": true,
        "include_hxl": true,
        "fields":"test",
        "filters":
        {
          "status" : ["published","draft"],
          "has_location" : "all",
          "orderby" : "created",
          "order" : "desc",
          "order_unlocked_on_top" : "true",
          "source" : ["sms","twitter","web","email"]
        },
        "entity_type":"post"
      }
    """
    When I request "/exports/jobs"
    Then the response is JSON
    And the response has a "id" property
    Then the guzzle status code should be 200
  Scenario: Create a export job for browser
    Given that I want to make a new "ExportJob"
    And that the oauth token is "testadminuser"
    And that the request "data" is:
    """
      {
        "send_to_browser": true,
        "send_to_hdx": false,
        "fields":"test",
        "filters":
        {
          "status" : ["published","draft"],
          "has_location" : "all",
          "orderby" : "created",
          "order" : "desc",
          "order_unlocked_on_top" : "true",
          "source" : ["sms","twitter","web","email"]
        },
        "entity_type":"post"
      }
    """
    When I request "/exports/jobs"
    Then the response is JSON
    And the response has a "id" property
    Then the guzzle status code should be 200
  Scenario: Create a export job for hdx fails if include_hxl is false
    Given that I want to make a new "ExportJob"
    And that the oauth token is "testadminuser"
    And that the request "data" is:
    """
      {
        "send_to_browser": false,
        "send_to_hdx": true,
        "include_hxl": false,
        "fields":"test",
        "filters":
        {
          "status" : ["published","draft"],
          "has_location" : "all",
          "orderby" : "created",
          "order" : "desc",
          "order_unlocked_on_top" : "true",
          "source" : ["sms","twitter","web","email"]
        },
        "entity_type":"post"
      }
    """
    When I request "/exports/jobs"
    Then the response is JSON
    And the response has a "errors" property
    And the "errors.1.message" property equals "include_hxl should be true when send_to_hdx is true"
    Then the guzzle status code should be 422
