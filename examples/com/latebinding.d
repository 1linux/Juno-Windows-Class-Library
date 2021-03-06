module juno.examples.com.latebinding;

import juno.com.core, juno.com.client;

void bind() {
  // Create an instance of the Message object
  scope message = new DispatchObject("CDO.Message");

  // Build the mail message
  message.set("Subject", "Hello, World!");
  message.set("TextBody", "Just saying Hello.");
  message.set("From", "me@home.com"); // Replace 'me@home.com' with your email address
  message.set("To", "someone@example.com"); // Replace 'someone@example.com' with the recipient's email address

  // Configure CDOSYS to send via a remote SMTP server

  scope config = message.get("Configuration");

  // Set the appropriate values
  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/sendusing", 2); // cdoSendUsingPort = 2

  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/smtpserverport", 25);

  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/smtpserver", "127.0.0.1"); // Replace '127.0.0.1' with your remote server's address

  // Set the authentication type, user name and password

  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", 1); // cdoBasic = 1

  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/sendusername", "username"); // Replace 'username' with your account's user name

  config.set("Fields", "http://schemas.microsoft.com/cdo/configuration/sendpassword", "password"); // Replace 'password' with your account's password

  scope fields = config.get("Fields");
  fields.call("Update");

  message.call("Send"); 
}

void main() {
  if (juno.com.core.initAsClient())
  {
    scope(exit) juno.com.core.shutdown();
    bind();
  }
}
