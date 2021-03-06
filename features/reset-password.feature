Feature: Reset passwords for one or more WordPress users.

  Scenario: Reset the password of a WordPress user
    Given a WP install

    When I run `wp user get 1 --field=user_pass`
    Then save STDOUT as {ORIGINAL_PASSWORD}

    When I run `wp user reset-password 1`
    Then STDOUT should contain:
      """
      Reset password for admin.
      Success: Passwords reset.
      """
    And an email should be sent

    When I run `wp user get 1 --field=user_pass`
    Then STDOUT should not contain:
      """
      {ORIGINAL_PASSWORD}
      """

  Scenario: Reset the password of a WordPress user, but skip emailing them
    Given a WP install

    When I run `wp user get 1 --field=user_pass`
    Then save STDOUT as {ORIGINAL_PASSWORD}

    When I run `wp user reset-password 1 --skip-email`
    Then STDOUT should contain:
      """
      Reset password for admin.
      Success: Passwords reset.
      """
    And an email should not be sent

    When I run `wp user get 1 --field=user_pass`
    Then STDOUT should not contain:
      """
      {ORIGINAL_PASSWORD}
      """
